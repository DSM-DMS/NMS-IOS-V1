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
        nameTextField.setUnderLine(color: UIColor(named: "MainColor2")!)
        schoolNumberTextField.setUnderLine(color: UIColor(named: "MainColor2")!)
        schoolNickTextField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    func setMain() {
        nextButton.rx.tap
            .bind {
            let secondSignUpViewController = SecondSignUpViewController()
            self.navigationController?.pushViewController(secondSignUpViewController, animated: true)
        }.disposed(by: disposeBag)
    }
    func setAddSubView() {
        self.nameTextField.delegate = self
        self.schoolNickTextField.delegate = self
        self.schoolNumberTextField.delegate = self
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
            $0.bottom.equalTo(-50)
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setUnderLine(color: UIColor(named: "MainColor1")!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    
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
