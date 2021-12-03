//
//  ViewController.swift
//  0Z-Project
//
//  Created by 김대희 on 2021/09/11.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa


class LoginAndSignupViewController: UIViewController {
    
    let disposeBag = DisposeBag()
   
    let MNSLabel = UILabel().then {
        $0.text = "Notice Management System"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont(name: "TwCenClassMTStd-Regular", size: 17.0)
    }
    let backImage = UIImageView().then {
        $0.image = UIImage(named: "LoginAndSignupBack1")
    }
    let MainLogoImage = UIImageView().then {
        $0.image = UIImage(named: "MainLogoWhite")
        $0.backgroundColor = .clear
    }
    
    let loginButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("LOGIN", for: .normal)
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 20.0)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 2
    }
    let signupButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("SIGN UP", for: .normal)
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 20.0)
        $0.setTitleColor(UIColor(named: "MainColor1"), for: .normal)
        $0.layer.cornerRadius = 25.5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setAddSubView()
        setMain()
        setConstent()
        
    }

    func setAddSubView() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(backImage)
//        view.addSubview(MNSLabel)
        view.addSubview(MainLogoImage)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
    }
    func setMain()  {
        loginButton.rx.tap
            .bind {
                let mainLoginViewController = MainLoginViewController()
                self.navigationController?.pushViewController(mainLoginViewController, animated: true)
            }.disposed(by: disposeBag)
        signupButton.rx.tap
            .bind {
                let firstSignUpViewController = FirstSignUpViewController()
                self.navigationController?.pushViewController(firstSignUpViewController, animated: true)
            }.disposed(by: disposeBag)
    }
    
    func setConstent() {
        backImage.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }

        MainLogoImage.snp.makeConstraints {
            $0.width.equalTo(110)
            $0.height.equalTo(110)
            $0.centerY.equalTo(self.view).offset(-80)
            $0.centerX.equalTo(self.view).offset(0)

        }
        loginButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.centerY.equalTo(self.view).offset(240)
            $0.centerX.equalTo(self.view).offset(0)
        }
        signupButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.centerY.equalTo(self.view).offset(321)
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
}
