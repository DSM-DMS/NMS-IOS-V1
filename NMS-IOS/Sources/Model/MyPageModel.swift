//
//  MyPageModel.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/12.
//

import Foundation

struct MyPageModel : Codable {
    let nickname : String
    let name : String
    let gcn : String?
    let email : String
    let profile_url : String?
    let stared_notices : [StaredNotice]?
}
struct StaredNotice : Codable {
    let id : Int
    let title : String
    let writer : String
    let department : String
    let created_date : String
    let image : String
}
