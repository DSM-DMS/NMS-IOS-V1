//
//  MainNotice.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/11.
//

import Foundation

struct NoticeSucces : Codable {
    let notice_count : Int
    let notices : [Notices]
}
struct Notices : Codable {
    let notice_id : Int
    let title : String
    let content : String
    let writer : writer
    let targets : [String]?
    let created_date : String
    let updated_date : String
    let images : [String]?
    
    let is_star : Bool?
    let star_count : Int
    let comment_count : Int
    let comments : [comments]?
    
}

struct writer : Codable {
    let name : String
    let profile_url : String?
}

struct comments : Codable {
    let id : Int
    let writer : writer
    let content : String
    let created_date : String
    let reply_count : Int
    let replies : [replies]
}

struct replies : Codable {
    let id : Int
    let writer : writer
    let content : String
    let created_date : String
}

func targetKoreanChanged(target : String) -> String {
    if target == "GRADE_FIRST" {
        return "1학년"
    }
    else if target == "GRADE_SECOND" {
        return "2학년"
    }
    else if target == "GRADE_THIRD" {
        return "3학년"
    }
    else if target == "SCHOOL" {
        return "교내"
    }
    else if target == "SUBURBS" {
        return "교외"
    }
    else {
        return "에러"
    }
}
