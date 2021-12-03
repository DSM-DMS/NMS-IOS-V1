//
//  SignUpViewModel.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/05.
//

import Foundation
import RxSwift
import RxCocoa

final class MyViewModel: ViewModelType {
    struct Dependency {
        var name: String?
        var schoolNumber: String?
        var grade : String?
        
    }

    struct Input {
        var nameText: AnyObserver<String?>
        var schoolNumberText: AnyObserver<String?>
        
    }

    struct Output {
        var isConfirmEnabled: Driver<Bool>
    }

    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output

    private let nameText$: BehaviorSubject<String?>
    private let emailText$: BehaviorSubject<String?>

    init(dependency: Dependency = Dependency(name: nil, schoolNumber: nil)) {
        self.dependency = dependency

        // Streams
        let nameText$ = BehaviorSubject<String?>(value: nil)
        let emailText$ = BehaviorSubject<String?>(value: nil)
        let isConfirmEnabled$ = Observable.combineLatest(nameText$, emailText$)
            .map(validation)
            .asDriver(onErrorJustReturn: false)

        // Input & Output
        self.input = Input(nameText: nameText$.asObserver(),
                           schoolNumberText: emailText$.asObserver())
        self.output = Output(isConfirmEnabled: isConfirmEnabled$)

        // Binding
        self.nameText$ = nameText$
        self.emailText$ = emailText$
    }
}

private func validation(name: String?, email: String?) -> Bool {
    return name?.isEmpty == false && email?.isEmpty == false
}
