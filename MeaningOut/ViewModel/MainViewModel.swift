//
//  MainViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/21/24.
//

import Foundation

final class MainViewModel {
    private let repository = UserDataRepository()
    
    // Input
    var viewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var updateSearchKeywordsTrigger: Observable<Void?> = Observable(nil)
    var inputSearchKeyword = Observable("")
    var deleteTrigger = Observable(0)
    var deleteAllTrigger: Observable<Void?> = Observable(nil)
    
    // Output
    var title = Observable("")
    var searchKeywordsList: Observable<[String]> = Observable([])
    var outputSearchResult = Observable(false)
    
    init() {
        setting()
        search()
    }
    
    private func setting() {
        viewWillAppearTrigger.bind { [weak self] _ in
            guard let self else { return }
            if let userData = self.repository.readUserData() {
                self.title.value = "\(userData.userName)'s ITEM"
                self.searchKeywordsList.value = Array(userData.searchKeywords)
            }
        }
    }
    
    private func search() {
        updateSearchKeywordsTrigger.bind { [weak self] _ in
            guard let self else { return }
            if let userData = self.repository.readUserData() {
                repository.updateUserData(value: ["id": userData.id, "searchKeywords": searchKeywordsList.value])
            }
        }
        
        inputSearchKeyword.bind { [weak self] keyword in
            guard let self else { return  }
            guard keyword.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 else {
                self.outputSearchResult.value = false
                return
            }
            
            if !self.searchKeywordsList.value.contains(keyword) {
                self.searchKeywordsList.value.insert(keyword, at: 0) // 가장 최근 검색어가 맨위에 와야하므로 검색어는 0번 인덱스에 넣어주기
            }
            self.outputSearchResult.value = true
            self.updateSearchKeywordsTrigger.value = ()
        }
        
        deleteTrigger.bind { [weak self] idx in
            guard let self else { return }
            self.searchKeywordsList.value.remove(at: idx)
            updateSearchKeywordsTrigger.value = ()
        }
        
        deleteAllTrigger.bind { [weak self] _ in
            guard let self else { return }
            self.searchKeywordsList.value.removeAll()
            updateSearchKeywordsTrigger.value = ()
        }
    }
}
