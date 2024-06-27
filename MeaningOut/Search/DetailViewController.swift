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
   
    var selectedItem: resultItem = resultItem(title: "", link: "", imagePath: "", price: "", mallName: "", productId: "")
   
    private let border = CustomBorder()
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        loadWebView()
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
        
        let rightItemImage = selectedItem.likeBtnImage
        let rightItem = UIBarButtonItem(image: rightItemImage, style: .plain, target: self, action: #selector(rightBarBtnTapped))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func rightBarBtnTapped(_ sender: UIButton) {
        resultItem.addOrRemoveLikeId(selectedItem.productId)
        navigationItem.rightBarButtonItem?.image = selectedItem.likeBtnImage
    }
    
    private func loadWebView() {
        // url로 전환 -> request 생성 -> request로 load
        // http 링크위해 ATS = YES
        guard let url = URL(string: selectedItem.link) else { return showAlert(alertCase: .detailURLError) { _ in self.navigationController?.popViewController(animated: true) } }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
