//
//  TokenModel.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/09.
//

import Foundation
import KeychainSwift

struct TokenModel: Codable {
    let access_token: String
    let refresh_token: String
}
struct Token {
    static var access_token: String = ""
    static var room_token: String?
    static var refresh_token: String? {
        get {
            let keychain = KeychainSwift()
            return keychain.get("refresh_token")
        }
        set {
            let keychain = KeychainSwift()
            keychain.set(newValue ?? "", forKey: "refresh_token")
        }
    }
}
