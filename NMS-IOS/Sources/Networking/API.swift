//
//  API.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/09.
//

import Foundation
import Alamofire

enum API {
    
    case checkPassword  // 기존 비밀번호 확인
    case login
    case signUp
    case reissiuTokens  // 토큰 재발급
    case reviseStudent  // 학생 정보 수정
    case myPage
    
    case checkEmail
    case sendEmail
    
    case checkAllPost
    case checkTargetPost( _ target : String)
    case checkJustPost( _ noticeId : Int)
    
    case bookMark( _ noticeId : Int)
    case cancelBookMark( _ noticeId : Int)
    
    case writeComment( _ noticeId : Int)
    case writeReComment( _ noticeId : Int)
    
    func path() -> String {
        switch self {
        case .checkPassword:
            return "/student/password"
        case .login:
            return "/student/auth"
        case .signUp:
            return "/student"
        case .reissiuTokens:
            return "/student/auth"
        case .reviseStudent:
            return "/student"
        case .myPage:
            return "/student/mypage"
        case .checkEmail:
            return "/email"
        case .sendEmail:
            return "/email"
        case .checkAllPost:
            return "/notice/all"
        case .checkTargetPost(let target):
            return "/notice?target=\(target)"
        case .checkJustPost(let noticeId):
            return "/notice/\(noticeId)"
        case .bookMark(let noticeId):
            return "/star?notice-id=\(noticeId)"
        case .cancelBookMark(let noticeId):
            return "/star?notice-id=\(noticeId)"
        case .writeComment(let noticeId):
            return "/comment?notice-id=\(noticeId)"
        case .writeReComment(let noticeId):
            return "/comment?id=\(noticeId)"
        }
    }
    func header() -> HTTPHeaders? {
        switch self {
            
        case .checkPassword, .reviseStudent, .myPage, .checkAllPost, .checkTargetPost(_),  .checkJustPost(_), .bookMark(_), .cancelBookMark(_), .writeComment(_), .writeReComment(_):
            return ["Authorization": "Bearer \(Token.access_token ?? "")"]
        case .login, .signUp, .checkEmail, .sendEmail:
            return nil
        case .reissiuTokens:
            return ["X-Refresh-Token": "Bearer \(Token.refresh_token ?? "")"]
        }
    }
}
