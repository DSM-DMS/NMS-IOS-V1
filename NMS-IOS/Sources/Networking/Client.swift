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

let baseURL = "http://13.209.176.77:8080"

class Client {
    typealias httpResult = Observable<(HTTPURLResponse, Data)>
    typealias statusCodeResult = Observable<HTTPURLResponse>

    func get(_ api : API, parameter : Parameters?) -> httpResult{
        return requestData(.get, baseURL + api.path(),
                           parameters: parameter,
                           encoding: JSONEncoding.prettyPrinted,
                           headers: api.header())
    }
    func post(_ api : API, parameter : Parameters?, encoding: ParameterEncoding = JSONEncoding.prettyPrinted) -> httpResult{
        return requestData(.post, baseURL + api.path(),
                           parameters: parameter,
                           encoding: encoding,
                           headers: api.header())
    }
    func postLike(_ api : API, parameter : Parameters?, encoding: ParameterEncoding = JSONEncoding.prettyPrinted) -> statusCodeResult{
        return response(.post, baseURL + api.path(),
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
enum StatusCodes: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case fault = 0
}
