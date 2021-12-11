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
    
    func allNoticeGet() -> Observable<( Notice?, StatusCodes)> {
        client.get(.checkAllPost, parameter: nil)
            .map{ response, data -> (Notice?, StatusCodes) in
                print(response)
                print(data)
                switch response.statusCode {
                case 200:
                    guard let data = try? JSONDecoder().decode(Notice.self, from: data) else { return (nil, .fault) }
                    print(data)
                    return (data, .success)
                default:
                    return (nil, .fault)
                }
            }

    }
    
}
