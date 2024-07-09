//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

struct ProfileImage {
    let imageName: String
    
    init(imageName: String = "") {
        self.imageName = imageName
    }
}

extension ProfileImage {
    var imageList: [ProfileImage] { [
        ProfileImage(imageName: "profile_0"),
        ProfileImage(imageName: "profile_1"),
        ProfileImage(imageName: "profile_2"),
        ProfileImage(imageName: "profile_3"),
        ProfileImage(imageName: "profile_4"),
        ProfileImage(imageName: "profile_5"),
        ProfileImage(imageName: "profile_6"),
        ProfileImage(imageName: "profile_7"),
        ProfileImage(imageName: "profile_8"),
        ProfileImage(imageName: "profile_9"),
        ProfileImage(imageName: "profile_10"),
        ProfileImage(imageName: "profile_11")
        ]
    }
    
    var randomImage: ProfileImage {
        return imageList.randomElement()!
    }
    
    // 임시 저장 이미지
    // 프로필 선택 / 수정 전 데이터 
    static var tempSelectedProfileImage: ProfileImage? 
}


