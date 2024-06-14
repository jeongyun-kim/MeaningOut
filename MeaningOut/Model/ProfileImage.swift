//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 김정윤 on 6/13/24.
//

import Foundation

struct ProfileImage {
    let imageName: String
}

extension ProfileImage {
    static var imageList: [ProfileImage] {
        var list: [ProfileImage] = []
        for i in (0...11) {
            list.append(ProfileImage(imageName: "profile_\(i)"))
        }
        return list
    }
    
    static var randomImage: ProfileImage {
        return imageList.randomElement()!
    }
}


