//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, SetupView {

    var profileViewType: ViewType = .setting
    private let profileList: [ProfileImage] = ProfileImage.imageList
    var tempProfileImage: ProfileImage = ProfileImage(imageName: "") {
        didSet {
            // 현재 선택한 이미지로 변경
            profileImageView.image = UIImage(named: tempProfileImage.imageName)
            // 현재 선택한 이미지, 아닌 이미지 셀 다시 그리기 위해
            collectionView.reloadData()
            // 임시 이미지 저장
            ProfileImage.tempSelectedProfileImage = tempProfileImage
        }
    }
    
    private let naviBorder = CustomBorder()
    private let profileLayerView = ProfileLayerView(.mainProfile)
    private let profileImageView = CustomImageView()
    private let badgeImage = ProfileBadgeView(.mainProfile)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupCollectionView()
        setupUI()
    }
    
    func setupHierarchy() {
        view.addSubview(naviBorder)
        view.addSubview(profileLayerView)
        profileLayerView.addSubview(profileImageView)
        view.addSubview(badgeImage)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        naviBorder.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        profileLayerView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(naviBorder.snp.bottom).offset(16)
        }
        
        badgeImage.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileLayerView).inset(ProfileLayerSizeCase.mainProfile.inset)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(profileLayerView)
            make.size.equalTo(profileLayerView.snp.width).multipliedBy(0.9)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileLayerView.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = profileViewType.rawValue
    }
    
    func setupCollectionView() {
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionInset: CGFloat = 16
        let spacing: CGFloat = 10
        let size = (UIScreen.main.bounds.width - spacing*3 - sectionInset*2) / 4
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.itemSize = CGSize(width: size, height: size)
        
        return layout
    }
}

// MARK: CollectionViewExtension
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        cell.configureCell(profileList[indexPath.row], nowSelectedProfileImage: tempProfileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tempProfileImage = profileList[indexPath.row]
    }
}
