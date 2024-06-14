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

    private lazy var itemList: [item] = [] {
        didSet {
            itemCollectionView.reloadData()
        }
    }
    
    lazy var tagNames = TagName.allCases
    
    lazy var keyword: String? = ""
    
    private lazy var border = CustomBorder()
    
    private lazy var productCntLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.bold16
        label.textColor = Color.primaryColor
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
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    
    private func itemCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionInsets: CGFloat = 16
        let spacing: CGFloat = 12
        let size = (UIScreen.main.bounds.width - sectionInsets*2 - spacing) / 2
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInsets, bottom: 0, right: sectionInsets)
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
        let params: Parameters = ["query": keyword, "sort": sortType.rawValue]
        AF.request(APIData.url, parameters: params, headers: APIData.header).responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let value):
                self.itemList = value.items
                self.productCntLabel.text = "\(value.total.formatted())개의 검색 결과"
            case .failure(let error):
                print(error)
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
            guard let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(tagNames[indexPath.row].rawValue)
            return cell
        } else {
            guard let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(itemList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
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
