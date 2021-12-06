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
    var badge : [String]?
    var LocationDate : String
    var LikeCount : Int
    var PostImage : UIImage?
    
    var CommentCount : Int
    init(title : String, body : String, locationDate : String, badge : [String]?, lileCount : Int, commentCount : Int, postImage : UIImage?) {
        self.Title = title
        self.Body = body
        self.LocationDate = locationDate
        self.LikeCount = lileCount
        self.CommentCount = commentCount
        self.PostImage = postImage
        self.badge = badge
    }
}

class MainPost {
    var list : [MainPostDume]
    init() {
        list = [
            MainPostDume(title: "[영상M] '해외전화를 010으로 조작'‥전화금융사기 일당 무더기 적발", body: "지난 8월 서울의 한 원룸텔. 방 안에는 휴대전화 수십 개가 널브러져 있습니다.중국에서 걸려온 금융사기 전화를 받아서 국내 번호인 010으로 바꿔주는 번호 조작장치로 활용한 겁니다.서울 강북경찰서는 서울과 경기, 부산 등 전국 원룸텔과 고시원, 오피스텔 등을 빌려 불법 중계기와 발신번호 조작용 휴대전화 등 144대를 설치해 중국의 전화금융사기를 도운 혐의로 14명을 붙잡아 이 가운데 5명을 구속했습니다.또 일당 중 일부는 '고액알바' '재택알바' '서버관리인 모집' 등 구인광고로 범행에 가담한 것으로 드러났다며 비교적 쉬운 업무에 고수익을 보장하는 광고는 각별한 주의가 필요하다고 덧붙였습니다.", locationDate: "2021-12-22", badge: [ "교외", "2학년"], lileCount: 122, commentCount: 25, postImage: UIImage(named: "DumeData")),
            MainPostDume(title: "오늘의 급식을 알려줄랭", body: "오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살 스테이크폭찹 등등 오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살스테이크폭찹 등등  ", locationDate: "2021-10-12", badge: ["2학년"],lileCount: 12, commentCount: 2, postImage: UIImage(named: "DumeData-1")),
            MainPostDume(title: "얘들아 있잖아얘들아 있잖아" , body: "6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면", locationDate: "2021-11-21", badge: [ "교내", "1학년"],lileCount: 122, commentCount: 1, postImage: nil),
            MainPostDume(title: "Apple Watch", body: "Apple Watch & MacBook Pto & Iphone 13 Pro Max모두 사실 여러분들을 구해요, \nIphone 13 Pro Max모두 사실 여러분들을 구해요", locationDate: "2021-11-11",badge: nil, lileCount: 14, commentCount: 10, postImage: UIImage(named: "DumeData-3")),
            MainPostDume(title: "오늘의 급식을 알려줄랭", body: "오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살 스테이크폭찹 등등 오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살스테이크폭찹 등등  ", locationDate: "2021-10-12", badge: ["2학년"],lileCount: 12, commentCount: 2, postImage: UIImage(named: "DumeData-1")),
            MainPostDume(title: "얘들아 있잖아얘들아 있잖아" , body: "6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기6줄 넘어가면 더보기 띄워주기 6줄 넘어가면 더보기 띄워주기 6줄 넘어가면", locationDate: "2021-11-21", badge: [ "교내", "1학년"],lileCount: 122, commentCount: 1, postImage: nil)
        ]
    }
}


struct DetailCommentDume {
    var commentHashtagBool : Bool?
    var id : Int?
    var userName : String?
    var userImage : UIImage?
    var locationDate : String?
    var commentBody : String?
}
class MainComment {
    var list : [DetailCommentDume]
    init() {
        list = [
            DetailCommentDume(commentHashtagBool: false, id: 0, userName: "1301 김대희", userImage: UIImage(named: "DumeData-3"), locationDate: "1분 전", commentBody: "이저 진짜임?? 놀랍다."),
            DetailCommentDume(commentHashtagBool: false, id: 1, userName: "1201 김지민", userImage: UIImage(named: "DumeData-1"), locationDate: "지금막", commentBody: "어쩔티비"),
            DetailCommentDume(commentHashtagBool: true, id: 1, userName: "장성해(마이스터부)", userImage: nil, locationDate: "1시간 전", commentBody: "일단은 내일 학교에서 보자. "),
            DetailCommentDume(commentHashtagBool: true, id: 0, userName: "1302 김범진", userImage: UIImage(named: "DumeData-4"), locationDate: "13분 전", commentBody: "이저 진짜임?? 놀랍다. ㄷㄷㄷ"),
            DetailCommentDume(commentHashtagBool: false, id: 1, userName: "1201 강석현", userImage: UIImage(named: "DumeData-5"), locationDate: "지금막", commentBody: "어쩔티비어쩔티비어쩔티비"),
            DetailCommentDume(commentHashtagBool: true, id: 1, userName: "장성해(마이스터부)", userImage: nil, locationDate: "1시간 전", commentBody: "일단은 내일 학교에서 보자. ㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
        ]
    }
}
