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
    private let vm = DetailViewModel()
    
    init(selectedItem: ResultItem) {
        super.init(nibName: nil, bundle: nil)
        self.vm.selectedItem = selectedItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let border = CustomBorder()
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        vm.loadWebViewTrigger.value = ()
        bind()
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
        navigationItem.title = vm.selectedItem.replacedTitle
        
        let rightItemImage = vm.selectedItem.likeBtnImage
        let rightItem = UIBarButtonItem(image: rightItemImage, style: .plain, target: self, action: #selector(rightBarBtnTapped))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func rightBarBtnTapped(_ sender: UIButton) {
        vm.likeBtnTapped.value = ()
    }

    private func bind() {
        vm.outputLikeResult.bind(handler: { [weak self] _ in
            guard let self else { return }
            self.navigationItem.rightBarButtonItem?.image = self.vm.selectedItem.likeBtnImage
        }, initRun: true)
        
        vm.outputLoadResult.bind(handler: { [weak self] (alert, request) in
            guard let self else { return }
            if let alert {
                self.showAlert(alertCase: alert) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                guard let request else { return }
                self.webView.load(request)
            }
        }, initRun: true)
    }
    
}
