//
//  LocalNotification.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/21/24.
//

import UIKit

final class LocalNotificationManager {
    private init() {}
    static let noti = LocalNotificationManager()
    private let repository = UserDataRepository()
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "오늘은 어떤 상품을 좋아요 해볼까요?"
        if let userData = repository.readUserData() {
            content.body = "현재 \(userData.likedItemList.count)개의 상품에 좋아요했어요"
        } else {
            content.body = "현재 0개의 상품에 좋아요했어요"
        }
        content.sound = .default
        
        var dateComponent = DateComponents()
        dateComponent.hour = 19
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
       
        let request = UNNotificationRequest(identifier: "like", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            if requests.filter({ $0.identifier == "like" }).count == 0 {
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
        
}
