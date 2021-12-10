//
//  Client.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/10.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

let baseURL = "http://13.209.48.160:8080"

class Client {
    typealias httpResult = Observable<(HTTPURLResponse, Data)>

    func get(_ api : API, parameter : Parameters?) -> httpResult{
        return requestData(.get, baseURL + api.path(),
                           parameters: parameter,
                           encoding: JSONEncoding.prettyPrinted,
                           headers: api.header())
    }
    func post(_ api : API, parameter : Parameters?, encoding: ParameterEncoding = JSONEncoding.default) -> httpResult{
        return requestData(.get, baseURL + api.path(),
                           parameters: parameter,
                           encoding: encoding,
                           headers: api.header())
    }
    func put(_ api: API, parameter: Parameters?, encoding: ParameterEncoding = JSONEncoding.default) -> httpResult {
        return requestData(.put, baseURL + api.path(),
                           parameters: parameter,
                           encoding: encoding,
                           headers: api.header())
    }
    func delete(_ api: API, parameter: Parameters?) -> httpResult {
        return requestData(.delete, baseURL + api.path(),
                           parameters: parameter,
                           encoding: JSONEncoding.prettyPrinted,
                           headers: api.header())
    }
    
}
