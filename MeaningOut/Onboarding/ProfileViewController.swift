//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

enum ProfileViewType: String {
    case setting = "PROFILE SETTING"
    case edit = "EDIT PROFILE"
}

class ProfileViewController: UIViewController, SetupView {
    
    lazy var nowSelectedImage: ProfileImage = ProfileImage(imageName: "") {
        didSet { // 현재 선택한 이미지로 변경
            profileView.imageView.image = UIImage(named: nowSelectedImage.imageName)
            collectionView.reloadData() // 현재 선택한 이미지, 아닌 이미지 셀 다시 그리기 위해
        }
    }
    
    lazy var naviBorder = CustomBorder()
    
    lazy var profileView = ProfileView(profile: nowSelectedImage)
    
    lazy var profileList: [ProfileImage] = ProfileImage.imageList
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    lazy var ProfileViewType: ProfileViewType = .setting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
    }
    
    func setupHierarchy() {
        view.addSubview(naviBorder)
        view.addSubview(profileView)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        naviBorder.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        profileView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(naviBorder.snp.bottom).offset(16)
            make.size.equalTo(120)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = ProfileViewType.rawValue
        profileView.layer.cornerRadius = 60
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        cell.configureCell(profileList[indexPath.row], nowData: nowSelectedImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nowSelectedImage = profileList[indexPath.row]
        UserDefaultsManager().selectedImage = nowSelectedImage.imageName
        print(UserDefaultsManager().selectedImage)
    }
}
