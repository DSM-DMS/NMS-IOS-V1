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
                default:
                    return (nil, .fault)
                }
            }
    }
}
