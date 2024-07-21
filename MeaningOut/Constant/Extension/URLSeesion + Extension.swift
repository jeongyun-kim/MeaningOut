//
//  URLSeesion + Extension.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/29/24.
//

import Foundation

extension URLSession {
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func customURLSessionDataTask(_ endPoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
}
