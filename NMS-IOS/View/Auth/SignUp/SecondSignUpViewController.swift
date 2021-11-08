//
//  SecondSignUpViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/07.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SecondSignUpViewController: UIViewController {
    let disposeBag = DisposeBag()
    let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = UIFont(name: "TwCenClassMTStd-Regular", size: 30.0)
        $0.textColor = UIColor.black
    }
    let emailTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 이메일(학교 이메일을 입력해주세요)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainBackColor1")
        $0.setTitle("인증번호를 입력하세요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setSearchController()
        setAddSubView()
        setConstent()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchController()
    }
    func setAddSubView() {
        view.addSubview(signUpLabel)
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
    }
    func setConstent() {

        signUpLabel.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(30)
            $0.top.equalTo(100)
            $0.centerX.equalTo(self.view).offset(0)
        }
        emailTextField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(200)
            $0.centerX.equalTo(self.view).offset(0)
        }
        nextButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.bottom.equalTo(-50)
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
    func setSearchController() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "MainBackColor1")
    }
    override func viewDidLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height + 3, width: emailTextField.frame.width + 8, height: 1)
        bottomLine.backgroundColor = UIColor(named: "MainColor1")?.cgColor
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(bottomLine)
    }
}
extension SecondSignUpViewController  {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!

        let keyboardFrame = notinfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let heiget = -(keyboardFrame.size.height - self.view.safeAreaInsets.bottom + 50)
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.bottom.equalTo(heiget)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.bottom.equalTo(-50)
            }
            self.view.layoutIfNeeded()
        }
    }

}
