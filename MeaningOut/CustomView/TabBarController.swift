//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        tabBar.tintColor = Color.primaryColor
        tabBar.unselectedItemTintColor = Color.gray2
        
        // 탭바에 연결할 뷰컨 불러오기
        let mainView = UINavigationController(rootViewController: MainViewController())
        mainView.tabBarItem = UITabBarItem(title: "검색", image: Images.search, tag: 0)
        
        let settingView = UINavigationController(rootViewController: SettingViewController())
        settingView.tabBarItem = UITabBarItem(title: "설정", image: Images.setting, tag: 1)
        
        // 탭바에 뷰컨 연결 
        setViewControllers([mainView, settingView], animated: true)
    }
}
