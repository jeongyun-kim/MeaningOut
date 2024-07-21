//
//  DetailViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/21/24.
//

import Foundation

final class DetailViewModel {
    private let repository = UserDataRepository()
    // 현재 선택한 아이템
    var selectedItem: ResultItem = ResultItem(title: "", link: "", imagePath: "", price: "", mallName: "", productId: "")
    
    // Input
    // 좋아요 등록/해제
    var likeBtnTapped: Observable<Void?> = Observable(nil)
    // 웹뷰 불러오기
    var loadWebViewTrigger: Observable<Void?> = Observable(nil)
    
    // Output
    // 좋아요에 따른 이미지 변경하기 위한 신호보내기
    var outputLikeResult: Observable<Void?> = Observable(nil)
    // 웹뷰 띄울 때, 에러메시지 또는 request 반환
    var outputLoadResult: Observable<(Resource.Alert?, URLRequest?)> = Observable((nil, nil))
    init() {
        likeBtnTapped.bind { [weak self] _ in
            guard let self else { return }
            self.repository.convertDataToItem(selectedItem)
            self.outputLikeResult.value = ()
        }
        
        loadWebViewTrigger.bind { [weak self] _ in
            guard let self else { return }
            // url로 전환 -> request 생성 -> request로 load
            // http 링크위해 ATS = YES
            guard let url = URL(string: self.selectedItem.link) else { return
                outputLoadResult.value = (Resource.Alert.detailURLError, nil)
            }
            let request = URLRequest(url: url)
            outputLoadResult.value = (nil, request)
        }
    }
}
