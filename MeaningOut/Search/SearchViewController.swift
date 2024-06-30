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
        self.keyword = keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ud = UserDefaultsManager.shared
    private var itemList: [resultItem] = []
    private let display: Int = 30
    private var startPoint: Int = 1
    private var maxStartPoint: Int = 0
    private let tagNames = TagName.allCases
    var keyword: String? = ""
    
    private let border = CustomBorder()
    private let productCntLabel = CustomLabel(color: ColorCase.primaryColor, fontCase: FontCase.bold16)
    private lazy var tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .searchTagCollectionViewLayout())
    private lazy var itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .itemCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupCollectionView()
        fetchSearchResults(.sim)
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
        navigationItem.title = keyword
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

    private func fetchSearchResults(_ sortType: SortRule) {
        guard let keyword = keyword else { return }
        NetworkService.shared.requestURLSessionCall(model: SearchResult.self, networkCase: .search(sortType: sortType, keyword: keyword, startPoint: startPoint, display: display)) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showToast(error.rawValue)
                } else {
                    guard let result = result else { return }
                    let items = result.items
                    // 결과 가져오는 시작점이 1이라면
                    if self.startPoint == 1 {
                        self.maxStartPoint = result.total
                        self.itemList = items // 아이템 리스트에 아이템 넣기
                        self.productCntLabel.text = "\(result.total.formatted())개의 검색 결과"
                    } else { // 결과 가져오는 시작점이 1이 아니라면 원래 있던 리스트 뒤에 아이템 붙여주기
                        self.itemList.append(contentsOf: items)
                    }
                    
                    self.itemCollectionView.reloadData()
                    
                    if self.startPoint == 1 && self.itemList.count > 0 { // 시작점이 1이라면 스크롤 맨위로
                        self.itemCollectionView.scrollToTheTop()
                    }
                }
            }
        }
    }

    @objc func likeBtnTapped(_ sender: UIButton) {
        // 현재 좋아요 누른 아이템 아이디
        let itemId = itemList[sender.tag].productId

        // 좋아요 처리 메서드 호출 
        resultItem.addOrRemoveLikeId(itemId)
        
        // reload 애니메이션 없이 좋아요한 셀만 리로드
        UIView.performWithoutAnimation {
            itemCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
        }
    }
}

// MARK: CollectionViewPrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            // 현재 보고있는 아이템이 27번째고 현재시작지점이 최대시작지점보다 작을 때
            if idx.row == itemList.count - 3 && startPoint < maxStartPoint {
                // 페이지를 넘기는게 아니라 검색 위치를 조정하는 것이기 때문에 매번 검색 위치는 보여주는 아이템 개수만큼 더하기
                startPoint += display
                guard let idx = tagCollectionView.indexPathsForSelectedItems?.first else { return }
                fetchSearchResults(SortRule.allCases[idx.row])
            }
        }
    }
}

// MARK: CollectionViewExtension
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == tagCollectionView ? tagNames.count : itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            cell.configureCell(tagNames[indexPath.row].rawValue)
            return cell
        } else {
            let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
            cell.configureCell(itemList[indexPath.row], keyword: keyword!)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView {
            let selectedItem = itemList[indexPath.row]
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
                startPoint = 1
                fetchSearchResults(SortRule.allCases[indexPath.row])
            } else {
                itemCollectionView.scrollToTheTop()
            }
        }
        return true
    }
}
