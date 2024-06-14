//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/14/24.
//

import UIKit
import SnapKit
import WebKit

class DetailViewController: UIViewController, SetupView {
   
    lazy var selectedItem: SearchItem = SearchItem(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")
   
    lazy var border = CustomBorder()
    
    lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        configureWebView()
    }

    func setupHierarchy() {
        view.addSubview(border)
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        border.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = selectedItem.replacedTitle
        
        let rightItemImage = selectedItem.likeImage
        let rightItem = UIBarButtonItem(image: rightItemImage, style: .plain, target: self, action: #selector(rightBarBtnTapped))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func rightBarBtnTapped(_ sender: UIButton) {
        SearchItem.addOrRemoveLikeId(selectedItem.productId)
        navigationItem.rightBarButtonItem?.image = selectedItem.likeImage
    }
    
    private func configureWebView() {
        // url로 전환 -> request 생성 -> request로 load
        // http 링크위해 ATS = YES
        let url = URL(string: selectedItem.link)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}