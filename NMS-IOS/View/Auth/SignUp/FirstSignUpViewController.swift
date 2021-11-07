//
//  FirstSignUpViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/04.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class FirstSignUpViewController: UIViewController {
    
    let gradeMenuButton = UIButton()
    let disposeBag = DisposeBag()
    let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = UIFont(name: "TwCenClassMTStd-Regular", size: 30.0)
        $0.textColor = UIColor.black
    }
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainBackColor1")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 2
    }
    
    let nameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 이름",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let schoolNumberTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 학번 (ex : 1301",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let schoolNickTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 닉네임",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    
    func setUI() {
        let grade1  = UIAction(title: "1학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 1학년", for: .normal)
            print("1학년 공통과정")
        })
        let grade2SW = UIAction(title: "2학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 2학년", for: .normal)
            print("2학년 소프트웨어 개발과")
        })
        let grade3 = UIAction(title: "3학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 3학년", for: .normal)
            print("3학년")
        })
        gradeMenuButton.setTitle(" 학년을 선택해주세요", for: .normal)
        gradeMenuButton.contentHorizontalAlignment = .left
        gradeMenuButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        gradeMenuButton.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
        gradeMenuButton.menu = UIMenu(title: "학년을 선택해 주세요", options: .displayInline, children: [grade1, grade2SW, grade3])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setUI()
        setMain()
        nameTextField.delegate = self
        setSearchController()
        setAddSubView()
        setConstent()
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchController()
    }
    override func viewDidLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: nameTextField.frame.height + 3, width: nameTextField.frame.width + 8, height: 1)
        bottomLine.backgroundColor = UIColor(named: "MainColor1")?.cgColor
        nameTextField.borderStyle = UITextField.BorderStyle.none
        nameTextField.layer.addSublayer(bottomLine)
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: schoolNumberTextField.frame.height + 3, width: schoolNumberTextField.frame.width + 8, height: 1)
        bottomLine2.backgroundColor = UIColor(named: "MainColor1")?.cgColor
        schoolNumberTextField.borderStyle = UITextField.BorderStyle.none
        schoolNumberTextField.layer.addSublayer(bottomLine2)
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 0.0, y: schoolNickTextField.frame.height + 3, width: schoolNickTextField.frame.width + 8, height: 1)
        bottomLine3.backgroundColor = UIColor(named: "MainColor1")?.cgColor
        schoolNickTextField.layer.addSublayer(bottomLine3)
        
    }
    
    func setMain() {
        nextButton.rx.tap
            .bind {
            let secondSignUpViewController = SecondSignUpViewController()
            self.navigationController?.pushViewController(secondSignUpViewController, animated: true)
        }.disposed(by: disposeBag)
    }
    func setAddSubView() {
        view.addSubview(signUpLabel)
        view.addSubview(nextButton)
        view.addSubview(nameTextField)
        view.addSubview(schoolNumberTextField)
        view.addSubview(schoolNickTextField)
        //        view.addSubview(gradeMenuButton)
    }
    func setConstent() {
        signUpLabel.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(30)
            $0.top.equalTo(100)
            $0.centerX.equalTo(self.view).offset(0)
        }
        nextButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.centerY.equalTo(self.view).offset(350)
            $0.centerX.equalTo(self.view).offset(0)
        }
        nameTextField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(200)
            $0.centerX.equalTo(self.view).offset(0)
        }
        schoolNumberTextField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(280)
            $0.centerX.equalTo(self.view).offset(0)
        }
        schoolNickTextField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(360)
            $0.centerX.equalTo(self.view).offset(0)
        }
        //        gradeMenuButton.snp.makeConstraints {
        //            $0.width.equalTo(356)
        //            $0.height.equalTo(35)
        //            $0.top.equalTo(360)
        //            $0.centerX.equalTo(self.view).offset(0)
        //        }
    }
    func setSearchController() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "MainBackColor1")
    }

}
extension FirstSignUpViewController : UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.centerY.equalTo(self.view).offset(100)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.centerY.equalTo(self.view).offset(350)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}
