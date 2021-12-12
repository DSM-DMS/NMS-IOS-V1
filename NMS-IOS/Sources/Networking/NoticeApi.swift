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
    
    func likeStarGet(noticeID : Int) -> Observable<StatusCodes> {
        client.post(.bookMark(noticeID), parameter: nil).map { response, data -> StatusCodes in
            print(data)
            print(response)
            switch response.statusCode {
            case 200:
                return (.success)
            default:
                return (.fault)
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
