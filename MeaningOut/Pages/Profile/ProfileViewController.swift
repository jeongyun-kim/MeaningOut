//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, SetupView {
    init(tempProfileImage: ProfileImage, profileViewType: ViewType = .setting) {
        super.init(nibName: nil, bundle: nil)
        self.tempProfileImage = tempProfileImage
        self.profileViewType = profileViewType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let vm = ProfileViewModel()
    var profileViewType: ViewType = .setting
    
    var tempProfileImage: ProfileImage = ProfileImage()
    
    private let naviBorder = CustomBorder()
    private let profileLayerView = ProfileLayerView(.mainProfile)
    private lazy var profileImageView: UIImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: tempProfileImage.imageName)
        return imageView
    }()
    private let badgeImage = ProfileBadgeView(.mainProfile)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .profileCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupCollectionView()
        setupUI()
        vm.viewDidLoadTrigger.value = ()
        bind()
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
    
    private func bind() {
        // 프로필 이미지 변경했다면 결과값(Bool) 받아와 UI 업데이트
        vm.outputChangeProfileImage.bind { boolResult, profileImage in
            if boolResult { // 결과가 true 라면
                // 현재 뷰의 tempProfileImage 교체
                self.tempProfileImage = profileImage
                // 현재 선택한 이미지 보여주기
                self.profileImageView.image = UIImage(named: self.tempProfileImage.imageName)
                // 컬렉션뷰 다시 그리기 
                self.collectionView.reloadData()
            }
        }
     }
}

// MARK: CollectionViewExtension
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.outputProfileList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        cell.configureCell(vm.outputProfileList.value[indexPath.row], nowSelectedProfileImage: tempProfileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = vm.outputProfileList.value[indexPath.row]
        vm.changeProfileImage.value = data
    }
}
