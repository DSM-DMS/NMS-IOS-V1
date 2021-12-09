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
    
    case checkEmail
    case sendEmail
    
    case checkAllPost
    case checkTargetPost( _ target : String)
    case checkJustPost( _ noticeId : String)
    
    case bookMark( _ noticeId : String)
    case cancelBookMark( _ noticeId : String)
    
    case writeComment( _ noticeId : String)
    case writeReComment( _ noticeId : String)
    
    
    
}
