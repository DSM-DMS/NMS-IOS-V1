//
//  API.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/09.
//

import Foundation

enum API {
    
    case checkPassword  // 기존 비밀번호 확인
    case login
    case signUo
    case reissiuTokens  // 토큰 재발급
    case reviseStudent  // 학생 정보 수정
    
    case myPage
    
}
