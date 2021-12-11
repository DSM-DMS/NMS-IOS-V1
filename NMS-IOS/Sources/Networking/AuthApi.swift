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
    func signup() -> Observable<StatusCodes> {
        
        let firstVC = FirstSignUpViewController()
        let secondVC = SecondSignUpViewController()
        let forthVC = FourthSignupViewController()
        let schoolNumber = firstVC.schoolNumberTextField.text
        
        let schoolNumArr = schoolNumber?.components(separatedBy: "")
        
        var gradeStr = "FIRST"
        
        let grade = schoolNumArr?[0]
        let classNum = schoolNumArr?[1]
        let number = (schoolNumArr?[2])! + (schoolNumArr?[3])!
        
        if grade == "1" {
            gradeStr = "FIRST"
        } else if grade == "2" {
            gradeStr = "SECOND"
        } else if grade == "3" {
            gradeStr = "THIRD"
        }
        return client.post(.signUp, parameter: [
            "nickname": "\(firstVC.schoolNickTextField.text!)",
            "name" : "\(firstVC.nameTextField.text!)",
            "grade" : "\(gradeStr)", //FIRST,SECOND, THIRD
            "class_num" : "\(classNum!)",
            "number" : "\(number)",
            "password" : "\(forthVC.rePassWordField.text!)",
            "email" : "\(secondVC.emailTextField.text!)"
        ]).map{response, data -> StatusCodes in
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
