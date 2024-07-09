//
//  Observable.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/9/24.
//

import Foundation

// 어떤 데이터도 받아올 수 있게 T
final class Observable<T> {
    // 받아오는 데이터
    var value: T {
        didSet {
            // 데이터가 갱신될때마다 클로저가 있다면 클로저 실행 및 value 보내기
            closure?(value)
        }
    }
    // 데이터 value가 갱신될 때마다 실행해 줄 클로저
    var closure: ((T) -> Void)?
    
    // Observable 인스턴스 생성 시, value에 대한 값 받아와 세팅
    init(_ value: T) {
        self.value = value
    }
    
    func bind(handler: @escaping (T) -> Void) {
        // init 시에도 실행되게
        handler(value)
        // 다음 번부터는 자동으로 해당 클로저 실행되게 클로저 변수에 대입
        self.closure = handler
    }
}
