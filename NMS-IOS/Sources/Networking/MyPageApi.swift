//
//  MyPageApi.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/11.
//

import Foundation

import Alamofire
import RxSwift

class MyPageApi {
    
    let client = Client()
    
    func myPageGet() -> Observable<(MyPageModel?, StatusCodes)> {
        client.get(.myPage, parameter: nil)
            .map{ response, data -> (MyPageModel?, StatusCodes) in
                switch response.statusCode {
                case 200:
                    do {
                        let data = try JSONDecoder().decode(MyPageModel.self, from: data)
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
}
