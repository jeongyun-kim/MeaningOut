//
//  LocalNotification.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/21/24.
//

import UIKit

class LocalNotification {
    private init() {}
    static let noti = LocalNotification()
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "오늘은 어떤 상품을 좋아요 해볼까요?"
        content.body = "현재 \(UserDefaultsManager.shared.likeCnt)개의 상품에 좋아요했어요"
        
        var dateComponent = DateComponents()
        dateComponent.hour = 19
     
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
