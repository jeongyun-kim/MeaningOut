//
//  SearchViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/21/24.
//

import Foundation

final class SearchViewModel {
    private let repository = UserDataRepository()
    
    let tagNames = Resource.TagName.allCases
    let display: Int = 30
    var startPoint: Int = 1
    var maxStartPoint: Int = 0
    var keyword: String = ""
    
    // Input
    // 네트워크 통신 시
    var inputSearchTrigger: Observable<SortRule> = Observable(.sim)
    // 페이지네이션
    var prefetchingTrigger: Observable<SortRule> = Observable(.sim)
    // 변경한 태그로 다시 네트워크 통신
    var reloadItemList: Observable<SortRule> = Observable(.sim)
    // 좋아요 등록 / 해제
    var likeBtnTapped = Observable(0)
    
    // Output
    // 네트워크 통신 에러
    private (set) var errorMessage: Observable<String?> = Observable(nil)
    // 통신 결과로 받아온 아이템 리스트
    var itemList: Observable<[ResultItem]> = Observable([])
    // 통신 결과로 받아온 아이템의 총개수
    var itemCount = Observable("")
    // 통신 결과가 끝났음을 알리는 신호
    var endedRequestTrigger: Observable<Void?> = Observable(nil)
    // 좋아요 등록/해제한 셀 reload
    var reloadCell = Observable(0)
    
    init() {
        transform()
    }
    
    private func transform() {
        reloadItemList.bind { [weak self] sort in
            guard let self else { return }
            self.startPoint = 1
            self.inputSearchTrigger.value = sort
        }
        
        prefetchingTrigger.bind { [weak self] sort in
            guard let self else { return }
            // 페이지를 넘기는게 아니라 검색 위치를 조정하는 것이기 때문에 매번 검색 위치는 보여주는 아이템 개수만큼 더하기
            self.startPoint += self.display
            self.inputSearchTrigger.value = sort
        }
        
        inputSearchTrigger.bind { [weak self] sort in
            guard let self else { return }
            NetworkService.shared.requestURLSessionCall(model: SearchResult.self, networkCase: .search(sortType: sort, keyword: self.keyword, startPoint: self.startPoint, display: self.display)) { result, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage.value = error.rawValue
                        return
                    } else {
                        guard let result = result else { return }
                        let items = result.items
                        // 결과 가져오는 시작점이 1이라면
                        if self.startPoint == 1 {
                            self.maxStartPoint = result.total
                            self.itemList.value = items // 아이템 리스트에 아이템 넣기
                            self.itemCount.value = "\(result.total.formatted())개의 검색 결과"
                            //self.productCntLabel.text = "\(result.total.formatted())개의 검색 결과"
                        } else { // 결과 가져오는 시작점이 1이 아니라면 원래 있던 리스트 뒤에 아이템 붙여주기
                            self.itemList.value.append(contentsOf: items)
                        }
                        self.errorMessage.value = nil
                        self.endedRequestTrigger.value = ()
                    }
                }
            }
        }
        
        likeBtnTapped.bind { [weak self] idx in
            guard let self else { return }
            // 현재 좋아요 누른 아이템 아이디
            let data = self.itemList.value[idx]
            self.repository.convertDataToItem(data)
            self.reloadCell.value = idx
        }
    }
}
