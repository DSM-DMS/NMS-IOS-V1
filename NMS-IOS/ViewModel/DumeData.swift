//
//  DumeData.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/18.
//

import Foundation
import UIKit

struct MainPostDume {
    var Title : String
    var Body : String
    var LocationDate : String
    var LikeCount : Int
    var PostImage : UIImage?
    
    var CommentCount : Int
    init(title : String, body : String, locationDate : String, lileCount : Int, commentCount : Int, postImage : UIImage?) {
        self.Title = title
        self.Body = body
        self.LocationDate = locationDate
        self.LikeCount = lileCount
        self.CommentCount = commentCount
        self.PostImage = postImage
    }
}

class MainPost {
    var list : [MainPostDume]
    init() {
        list = [
            MainPostDume(title: "오늘의 급식을 알려줄랭", body: "오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살 스테이크폭찹 등등 오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살스테이크폭찹 등등  ", locationDate: "2021-10-12", lileCount: 12, commentCount: 2, postImage: UIImage(named: "DumeData-1")),
            MainPostDume(title: "얘들아 있잖아얘들아 있잖아" , body: "6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면", locationDate: "2021-11-21", lileCount: 122, commentCount: 1, postImage: nil),
            MainPostDume(title: "Apple Watch", body: "Apple Watch & MacBook Pto & Iphone 13 Pro Max모두 사실 여러분들을 구해요, \nIphone 13 Pro Max모두 사실 여러분들을 구해요", locationDate: "2021-11-11", lileCount: 14, commentCount: 10, postImage: UIImage(named: "DumeData-3"))
            
        ]
    }
}
