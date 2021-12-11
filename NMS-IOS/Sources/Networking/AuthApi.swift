//
//  AuthApi.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/11.
//

import Foundation

import Alamofire
import RxSwift
import RxCocoa

class AuthApi {
    
    let client = Client()
    
    func login(email : String?, password : String?) -> Observable<StatusCodes> {
        return client.post(.login, parameter: [
            "email": "\(email!)", "password": "\(password!)"])
            .map{response, data -> StatusCodes in
                print(data)
                print("----------\(response.statusCode)---------------")
                switch response.statusCode {
                case 200:
                    guard let data = try? JSONDecoder().decode(TokenModel.self, from: data) else {
                        return .fault
                    }
                    print(data.access_token)
                    Token.access_token = data.access_token
                    Token.refresh_token = data.refresh_token
                    return .success
                default:
                    print(Error.self)
                    print(response.statusCode)
                    return .fault
                }
            }
    }
}
