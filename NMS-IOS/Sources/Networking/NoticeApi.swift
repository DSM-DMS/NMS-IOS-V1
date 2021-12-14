//
//  NoticeApi.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/11.
//

import Foundation

import Alamofire
import RxSwift

class NoticeApi {
    let client = Client()
    
    func allNoticeGet() -> Observable<( NoticeSucces?, StatusCodes)> {
        client.get(.checkAllPost, parameter: nil)
            .map{ response, data -> (NoticeSucces?, StatusCodes) in
                print(Token.access_token ?? "")
                switch response.statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(NoticeSucces.self, from: data)
                        return (data, .success)
                    }
                    catch {
                        print("Parse Error : \n \(error)")
                        return (nil, .fault)
                    }
                case 404:
                    return (nil, .notFound)
                default:
                    return (nil, .fault)
                }
            }
    }
    
    func targetNoticeGet(target : String) -> Observable<( NoticeSucces?, StatusCodes)> {
        client.get(.checkTargetPost(target), parameter: nil)
            .map {response, data -> (NoticeSucces?, StatusCodes) in
                print(Token.access_token ?? "")
                switch response.statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(NoticeSucces.self, from: data)
                        return (data, .success)
                    }
                    catch {
                        print("Parse Error : \n \(error)")
                        return (nil, .fault)
                    }
                case 404:
                    return (nil, .notFound)
                default:
                    return (nil, .fault)
                }
            }
    }
    func DevTargetNoticeGet(target : String) -> Observable<( DevNoticeSucces?, StatusCodes)> {
        client.get(.checkTargetPost(target), parameter: nil)
            .map {response, data -> (DevNoticeSucces?, StatusCodes) in
                print(Token.access_token ?? "")
                print(response)
                switch response.statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(DevNoticeSucces.self, from: data)
                        return (data, .success)
                    }
                    catch {
                        print("Parse Error : \n \(error)")
                        return (nil, .fault)
                    }
                case 404:
                    return (nil, .notFound)
                default:
                    return (nil, .fault)
                }
            }
    }
    func justNoticeGet(noticeID : Int) -> Observable<( Notices?, StatusCodes)> {
        client.get(.checkJustPost(noticeID), parameter: nil)
            .map {response, data -> (Notices?, StatusCodes) in
                print(Token.access_token ?? "")
                switch response.statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(Notices.self, from: data)
                        return (data, .success)
                    }
                    catch {
                        print("Parse Error : \n \(error)")
                        return (nil, .fault)
                    }
                case 404:
                    return (nil, .notFound)
                default:
                    return (nil, .fault)
                }
            }
    }
    func postComment(content : String, noticeID : Int) -> Observable<StatusCodes> {
        client.postLike(.writeComment(noticeID), parameter: ["content" : content]).map { response -> StatusCodes in
            print("----=-=--=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-")
            print(response)
            print("----=-=--=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-")
            switch response.statusCode {
            case 201:
                return .success
            default:
                return .fault
            }
        }

    }
    func likeStarGet(noticeID : Int) -> Observable<StatusCodes> {
        client.postLike(.bookMark(noticeID), parameter: nil).map { response -> StatusCodes in
            print(response)
            switch response.statusCode {
            case 201:
                return .success
            default:
                return .fault
            }
        }
    }
    func unLikeStarGet(noticeID : Int) -> Observable<StatusCodes> {
        client.delete(.cancelBookMark(noticeID), parameter: nil).map { response, data -> StatusCodes in
            switch response.statusCode {
            case 204:
                return (.success)
            default:
                return (.fault)
            }
        }
    }
}
