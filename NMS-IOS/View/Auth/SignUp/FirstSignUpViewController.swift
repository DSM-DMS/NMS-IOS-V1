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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    }

    func setAddSubView() {
        view.addSubview(nextButton)
        view.addSubview(nameTextField)
        view.addSubview(schoolNumberTextField)
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
