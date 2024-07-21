//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, SetupView {
    init(keyword: String) {
        super.init(nibName: nil, bundle: nil)
        self.vm.keyword = keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let vm = SearchViewModel()
    private let border = CustomBorder()
    private let productCntLabel = CustomLabel(color: Resource.ColorCase.primaryColor, fontCase: Resource.FontCase.bold16)
    private lazy var tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .searchTagCollectionViewLayout())
    private lazy var itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .itemCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupCollectionView()
        vm.inputSearchTrigger.value = .sim
        bind()
    }
    
    // 상세보기에서 좋아요를 등록하거나 해제할 수 있기때문에 뷰 불러올때마다 변경된 상태 반영
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemCollectionView.reloadData()
    }
    
    func setupHierarchy() {
        view.addSubview(border)
        view.addSubview(productCntLabel)
        view.addSubview(tagCollectionView)
        view.addSubview(itemCollectionView)
    }
    
    func setupConstraints() {
        border.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        productCntLabel.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(productCntLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
        
        itemCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = vm.keyword
        navigationItem.backButtonTitle = ""
    }
    
    func setupCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        tagCollectionView.isScrollEnabled = false
        tagCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
        
        itemCollectionView.prefetchDataSource = self
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    private func bind() {
        vm.errorMessage.bind { [weak self] errorMessage in
            guard let self else { return }
            guard let errorMessage else { return }
            self.showToast(errorMessage)
        }
        
        vm.endedRequestTrigger.bind { [weak self] _ in
            guard let self else { return }
            self.itemCollectionView.reloadData()
            self.productCntLabel.text = self.vm.itemCount.value
            // 시작점이 1이라면 스크롤 맨위로
            if self.vm.startPoint == 1 && self.vm.itemList.value.count > 0 {
                self.itemCollectionView.scrollToTheTop()
            }
        }
    
        vm.reloadCell.bind { [weak self] idx in
            guard let self else { return }
            UIView.performWithoutAnimation {
                self.itemCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
        }
    }

    @objc func likeBtnTapped(_ sender: UIButton) {
        vm.likeBtnTapped.value = sender.tag
    }
}

// MARK: CollectionViewPrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            // 현재 보고있는 아이템이 27번째고 현재시작지점이 최대시작지점보다 작을 때
            if idx.row == vm.itemList.value.count - 3 && vm.startPoint < vm.maxStartPoint {
                guard let idx = tagCollectionView.indexPathsForSelectedItems?.first else { return }
                let sort = SortRule.allCases[idx.row]
                vm.prefetchingTrigger.value = sort
            }
        }
    }
}

// MARK: CollectionViewExtension
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == tagCollectionView ? vm.tagNames.count : vm.itemList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            cell.configureCell(vm.tagNames[indexPath.row].rawValue)
            return cell
        } else {
            let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
            cell.configureCell(vm.itemList.value[indexPath.row], keyword: vm.keyword)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView {
            let selectedItem = vm.itemList.value[indexPath.row]
            pushVC(vc: DetailViewController(selectedItem: selectedItem))
        }
    }
    
    // 셀 그리기 전에 호출
    // 검색결과 보여줄 때마다 0번째(정확도순)에 선택 표시
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.isSelected = true
        }
    }
    
    // 태그 셀이 새로 눌러질 때, 이전 태그랑 현재 누르고 있는 태그를 비교해서 같다면 스크롤만 위로 올리기 / 다르다면 네트워크 통신
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == tagCollectionView {
            let beforeIdx = collectionView.indexPathsForSelectedItems?.first?.row
            let afterIdx = indexPath.row
            
            if beforeIdx != afterIdx {
                let sort = SortRule.allCases[indexPath.row]
                vm.reloadItemList.value = sort
            } else {
                itemCollectionView.scrollToTheTop()
            }
        }
        return true
    }
}
