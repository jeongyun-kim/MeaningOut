//
//  ProfileNicknameViewModel.swift
//  MeaningOut
//
//  Created by 김정윤 on 7/9/24.
//

import Foundation

class ProfileNicknameViewModel {
    private let repository = UserDataRepository()
    // Input
    // NicknameVC로부터 닉네임 텍스트필드가 변경될 때마다 받아오는 닉네임 데이터
    var inputNicknameForCheck: Observable<String> = Observable("")
    // 사용자 정보를 저장하고 싶을 때
    var saveBtnTapped: Observable<[String: String]?> = Observable([:])
    // 사용자가 닉네임을 수정하려고 ProfileNicknameVC를 edit 타입으로 들어왔을 때
    var isEditMode = Observable(false)
    
    
    // Output
    // 닉네임 텍스트 필드가 변경될 때마다 에러 처리를 통해 들어온 닉네임 유효성 확인 타입 반환
    var outputNicknameCheckType: Observable<NicknameCheckType> = Observable(.empty)
    // 편집모드로 들어올 때마다 보내줄 현재 저장되어있는 사용자 정보
    var outputUserData: Observable<UserData?> = Observable(nil)
    
    
    
    init() {
        inputNicknameForCheck.bind { nickname in
            do {
                let _ = try self.validateNickname(nickname)
                self.outputNicknameCheckType.value = .confirm
            } catch {
                // 각 에러 케이스에 따라 닉네임 유효성에 대해 필터링해주는 Case 변경
                switch error {
                case NicknameErrorCase.empty:
                    self.outputNicknameCheckType.value = .empty
                case NicknameErrorCase.wrongNicknameCnt:
                    self.outputNicknameCheckType.value = .wrongNicknameCnt
                case NicknameErrorCase.containsNumber:
                    self.outputNicknameCheckType.value = .containsNumber
                case NicknameErrorCase.containsSpecialCharacter:
                    self.outputNicknameCheckType.value = .containsSpecialCharacter
                default:
                    break
                }
            }
        }
        
        saveBtnTapped.bind { _ in
            self.saveUserData()
        }
        
        isEditMode.bind { value in
            if value {
                guard let userData = self.repository.readUserData() else { return }
                self.outputUserData.value = userData
            }
        }
    }

    // MARK: 닉네임 유효성 확인
    private func validateNickname(_ text: String) throws ->  Bool {
        // 숫자가 있는 상황에서 @를 입력할 경우에 숫자가 포함되서는 안된다는 메시지만 출력됨
        // 이를 방지하기 위해 마지막 문자까지 비교
        guard let lastChr = text.last else {
            throw NicknameErrorCase.empty
        }
        // 마지막 글자가 특수문자인지 확인
        guard !["$", "%", "@", "#"].contains(lastChr) else {
            throw NicknameErrorCase.containsSpecialCharacter
        }
        guard Int(String(describing: lastChr)) == nil else {
            throw NicknameErrorCase.containsNumber
        }
        
        // 전체 문자 확인
        // 공백 모두 제거한 문자열의 길이
        let removeWhiteSpaceCnt = text.trimmingCharacters(in: .whitespacesAndNewlines).count
        // 닉네임에 숫자가 들어있는지
        let isContainsNumber = text.range(of: NicknameRegex.number, options: .regularExpression) != nil
        // 닉네임에 # $ @ % 가 들어있는지
        let isContainsSpecialChr = text.range(of: NicknameRegex.specialCharacter, options: .regularExpression) != nil
        
        guard removeWhiteSpaceCnt >= 2 && removeWhiteSpaceCnt <= 10 else {
            throw NicknameErrorCase.wrongNicknameCnt
        }
        guard !isContainsNumber else {
            throw NicknameErrorCase.containsNumber
        }
        guard !isContainsSpecialChr else {
            throw NicknameErrorCase.containsSpecialCharacter
        }
        return true
    }

    // MARK: 유저 데이터 저장 / 업데이트
    private func saveUserData() {
        guard let value = saveBtnTapped.value else { return }
        guard let name = value[UserDataKeyCase.userName.rawValue] else { return }
        guard let profileImage = value[UserDataKeyCase.userProfileImageName.rawValue] else { return }
        
        if let userData = repository.readUserData() {
            let value: [String: Any] = ["id": userData.id, "userName": name, "userProfileImageName": profileImage]
            repository.updateUserData(value: value)
        } else {
            repository.createUserData(name: name, profileImage: profileImage, joinDate: getJoinDate())
        }
    }
    
    // MARK: 가입 날짜 구하기
    private func getJoinDate() -> String {
        let dateFormatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "YYYY.MM.dd 가입"
        let result = dateFormatter.string(from: Date())
        return result
    }
}
