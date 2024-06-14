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
   
    lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        configureWebView()
    }

    func setupHierarchy() {
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = selectedItem.replacedTitle
    }
    
    private func configureWebView() {
        // url로 전환 -> request 생성 -> request로 load
        // http 링크위해 ATS = YES
        let url = URL(string: selectedItem.link)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
