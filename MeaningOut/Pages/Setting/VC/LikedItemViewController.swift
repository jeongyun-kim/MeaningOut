//
//  LikedItemViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/7/24.
//

import UIKit
import SnapKit

// 한 줄에 3개 들어가는 컬렉션뷰 만들기!
final class LikedItemViewController: BaseCollectionViewController {
    private let vm = LikeViewModel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .itemCollectionViewLayout(.like))
    private let border = CustomBorder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.reloadLikeItemsTrigger.value = ()
    }
    
    override func setupHierarchy() {
        view.addSubview(border)
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        border.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "나의 장바구니 목록"
    }
    
    override func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikedItemCollectionViewCell.self, forCellWithReuseIdentifier: LikedItemCollectionViewCell.identifier)
    }
    
    @objc func likeBtnTapped(_ sender: UIButton) {
        vm.likeBtnTapped.value = sender.tag
    }
    
    private func bind() {
        vm.likedItemList.bind { [weak self] _ in
            guard let self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension LikedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.likedItemList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedItemCollectionViewCell.identifier, for: indexPath) as! LikedItemCollectionViewCell
        let item = vm.likedItemList.value[indexPath.row]
        cell.configureCell(item)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        return cell
    }
}
