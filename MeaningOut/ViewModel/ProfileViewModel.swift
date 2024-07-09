//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/9/24.
//

import Foundation

final class ProfileViewModel {
    // Input
    // viewDidLoad 시 신호 받아오기
    var viewDidLoadTrigger: Observable<Void?> = Observable(nil)
    // 프로필 이미지가 새로 선택될 때마다 해당 이미지 받아오기
    var changeProfileImage: Observable<ProfileImage?> = Observable(nil)
    
    // Output
    // viewDidLoad시 던져주는 ProfileImage들의 리스트
    var outputProfileList: Observable<[ProfileImage]> = Observable([])
    // ProfileImage 모델 내 임시 프로필 이미지가 변경되었음을 확인
    var outputChangeProfileImage: Observable<(Bool, ProfileImage)> = Observable((false, ProfileImage()))
    
    init() {
        // ProfileVC가 불러와지면 프로필이미지 모델의 프로필 이미지 리스트 건내주기
        viewDidLoadTrigger.bind { _ in
            self.outputProfileList.value = ProfileImage().imageList
        }
        
        // 지금 선택중인 이미지로
        changeProfileImage.bind { profileImage in
            guard let profileImage else { return }
            // ProfileImage 모델 내 tempSelectedProfileImage의 데이터 변경해주기
            ProfileImage.tempSelectedProfileImage = profileImage
            // 데이터가 변경됐음을 알려줌
            self.outputChangeProfileImage.value = (true, profileImage)
        }
    }
}
