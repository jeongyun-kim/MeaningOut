//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import Alamofire
import SnapKit

class SearchViewController: UIViewController, SetupView {

    lazy var ud = UserDefaultsManager.self
    
    // 좋아요한 아이디 리스트
    private lazy var likedItemIdList: [String] = ud.likedItemId {
        didSet { // 리스트 변경 시마다 저장
            ud.likedItemId = likedItemIdList
        }
    }
    
    private lazy var itemList: [item] = []
    
    private lazy var display: Int = 30
    
    private lazy var startPoint: Int = 1
    
    private lazy var maxStartPoint: Int = 0
    
    lazy var tagNames = TagName.allCases
    
    lazy var keyword: String? = ""
    
    private lazy var border = CustomBorder()
    
    private lazy var productCntLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.bold16
        label.textColor = ColorCase.primaryColor
        label.text = "202,122개의 검색 결과"
        return label
    }()
  
    private lazy var tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCollectionViewLayout())
    
    private lazy var itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: itemCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupCollectionView()
        fetchSearchResults(.sim)
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
    
    
    private func itemCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionInsetAndSpacing: CGFloat = 16
        let size = (UIScreen.main.bounds.width - sectionInsetAndSpacing * 3) / 2
        
        layout.minimumLineSpacing = sectionInsetAndSpacing
        layout.minimumInteritemSpacing = sectionInsetAndSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInsetAndSpacing, bottom: sectionInsetAndSpacing, right: sectionInsetAndSpacing)
        layout.itemSize = CGSize(width: size, height: size*1.7)
        
        return layout
    }
    
    private func tagCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func fetchSearchResults(_ sortType: SortRule) {
        guard let keyword = keyword else { return }
        let params: Parameters = ["query": keyword, "sort": sortType.rawValue, "display": display, "start": startPoint]
        AF.request(APIData.url, parameters: params, headers: APIData.header).responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let value):
                let items = value.items.map({
                    item(title: $0.title, link: $0.link, image: $0.image, lprice: $0.lprice, mallName: $0.mallName, productId: $0.productId)
                })
                
                if self.startPoint == 1 {
                    self.maxStartPoint = value.total
                    self.itemList = items
                    self.productCntLabel.text = "\(value.total.formatted())개의 검색 결과"
                } else {
                    self.itemList.append(contentsOf: items)
                }
                
                self.itemCollectionView.reloadData()
                
                if self.startPoint == 1 {
                    self.itemCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func likeBtnTapped(_ sender: UIButton) {
        // 현재 좋아요 누른 아이템 아이디
        let itemId = itemList[sender.tag].productId
        
        // 만약 이미 좋아요가 눌러져있던 아이템이라면 좋아요 리스트에서 삭제
        if likedItemIdList.contains(itemId) {
            guard let idx = ud.likedItemId.firstIndex(of: itemList[sender.tag].productId) else { return }
            likedItemIdList.remove(at: idx)
        } else { // 좋아요 리스트에 없던 아이디라면 좋아요 추가
            likedItemIdList.append(itemId)
        }
        
        // reload 애니메이션 없이 좋아요한 셀만 리로드
        UIView.performWithoutAnimation {
            itemCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
        }
    }
}

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
            cell.configureCell(itemList[indexPath.row])
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            startPoint = 1
            fetchSearchResults(SortRule.allCases[indexPath.row])
        }
    }
    
    // 셀 그리기 전에 호출
    // 검색결과 보여줄 때마다 0번째(정확도순)에 선택 표시
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.isSelected = true
        }
    }
}