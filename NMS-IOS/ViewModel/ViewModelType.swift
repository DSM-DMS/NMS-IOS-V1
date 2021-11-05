//
//  ViewModelType.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/05.
//

import Foundation
import RxSwift



protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set }
    
    var input: Input { get }
    var output: Output { get }
    
    init(dependency: Dependency)
}
