//
//  UIViewController + Extension.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit

extension UIViewController {
    func getNewScene(rootVC: UIViewController) {
        // 화면이 쌓이지 않은 채 등장!
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 가져온 windowScene의 sceneDelegate 정의
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
       
        let rootViewController = UINavigationController(rootViewController: rootVC)
        
        // 처음 보여질 화면 root로 설정하고 보여주기
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
