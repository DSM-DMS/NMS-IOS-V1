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


    func setUI() {
      
        let grade1  = UIAction(title: "1학년 공통과정", handler: {_ in
            self.gradeMenuButton.setTitle(" 1학년 공통과정", for: .normal)
            print("1학년 공통과정")
        })
        let grade2SW = UIAction(title: "2학년 소프트웨어 개발과", handler: {_ in
            self.gradeMenuButton.setTitle(" 2학년 소프트웨어 개발과", for: .normal)
            print("2학년 소프트웨어 개발과")
        })
        let grade2Se = UIAction(title: "2학년 정보보안과", handler: {_ in
            self.gradeMenuButton.setTitle(" 2학년 정보보안과", for: .normal)
            print("2학년 정보보안과")
        })
        let grade2EM = UIAction(title: "2학년 임배디드 소프트웨어과", handler: {_ in
            self.gradeMenuButton.setTitle(" 2학년 임배디드 소프트웨어과", for: .normal)
            print("2학년 임배디드 소프트웨어과")
        })
        let grade3 = UIAction(title: "3학년 공통", handler: {_ in
            self.gradeMenuButton.setTitle(" 3학년", for: .normal)
            print("3학년")
        })
        gradeMenuButton.setTitle(" 학년을 선택해주세요", for: .normal)
        gradeMenuButton.contentHorizontalAlignment = .left
        gradeMenuButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        gradeMenuButton.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
        gradeMenuButton.menu = UIMenu(title: "학년을 선택해 주세요", options: .displayInline, children: [grade1, grade2SW, grade2Se, grade2EM, grade3])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setUI()
        gradeMenuButton.rx.tap.bind {
          
        }.disposed(by: DisposeBag())
        nameTextField.delegate = self
        setSearchController()
        setAddSubView()
        setConstent()
    }
    private func bind() {
//        gradeMenuButton.menu
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
        bottomLine3.frame = CGRect(x: 0.0, y: gradeMenuButton.frame.height + 3, width: gradeMenuButton.frame.width + 8, height: 1)
        bottomLine3.backgroundColor = UIColor(named: "MainColor1")?.cgColor
        gradeMenuButton.layer.addSublayer(bottomLine3)

    }

    func setMain() {
        
    }
    func setAddSubView() {
        view.addSubview(nextButton)
        view.addSubview(nameTextField)
        view.addSubview(schoolNumberTextField)
        view.addSubview(gradeMenuButton)
    }
    func setConstent() {
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
        gradeMenuButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(360)
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
    func setSearchController() {
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "MainBackColor1")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
extension FirstSignUpViewController : UITextFieldDelegate {
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.centerY.equalTo(self.view).offset(60)
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
