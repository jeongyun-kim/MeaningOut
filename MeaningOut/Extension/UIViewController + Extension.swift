//
//  UIViewController + Extension.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/15/24.
//

import UIKit
import Toast

extension UIViewController {
    func getNewScene(rootVC: UIViewController) {
        // 화면이 쌓이지 않은 채 등장!
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 가져온 windowScene의 sceneDelegate 정의
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        // 처음 보여질 화면 root로 설정하고 보여주기
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func showAlert(alertCase: Alert, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: alertCase.title, message: alertCase.message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: Alert.confirmActionTitle, style: .default, handler: completionHandler)
        alert.addAction(confirm)
        
        if alertCase == .membershipCancel {
            let cancel = UIAlertAction(title: Alert.cancelActionTitle, style: .cancel)
            alert.addAction(cancel)
        }
        present(alert, animated: true)
    }
    
    func pushVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showToast(_ message: String) {
        self.view.makeToast(message)
    }
}
