//
//  FirstChangPassWordViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/29.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa


class FirstChangPassWordViewController: UIViewController {
    
    let bag = DisposeBag()
    var errorColor = Bool()

    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let backNavigationBarView  = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
    }
    let nowPasswordField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 현재 비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        $0.layer.borderWidth = 2
    }
    var errorLabel = UILabel().then {
//        $0.textAlignment = .left
        $0.textColor = .systemRed
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
        bindButton()

        nowPasswordField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addSubview(mainBackView)
        view.addSubview(backNavigationBarView)
        mainBackView.addSubview(nowPasswordField)
        mainBackView.addSubview(nextButton)
        makeConstraint()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        nowPasswordField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "현재 비밀번호 확인"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func makeConstraint() {
        mainBackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        backNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        nowPasswordField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(150)
            $0.centerX.equalTo(self.view).offset(0)
        }
        nextButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.bottom.equalTo(-35)
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
}
extension FirstChangPassWordViewController : UITextFieldDelegate {
    
    func bindButton() {
        nextButton.rx.tap.bind {
            if self.nowPasswordField.text == "" {
                self.errorColor = true
                print("--------\(self.nowPasswordField.text ?? "NULL")")
                self.errorLabel.text = "비밀번호를 입력하세요"
                self.mainBackView.addSubview(self.errorLabel)
                self.nowPasswordField.setUnderLine(color: UIColor.systemRed)
                self.changBottomColor(textField: self.nowPasswordField)
                self.errorLabel.snp.makeConstraints {
                    $0.top.equalTo(self.nowPasswordField.snp.bottom).offset(8)
                    $0.width.equalTo(356)
                    $0.height.equalTo(15)
                    $0.centerX.equalTo(self.view).offset(0)
                }
            }
            else {
                let secondChangePasswordViewController = SecondChangePasswordViewController()
                self.navigationController?.pushViewController(secondChangePasswordViewController, animated: true)

            }
        }.disposed(by: bag )
    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
   
        if errorColor == true {
            print("1")
            textField.setUnderLine(color: UIColor.systemRed)
            return true
        } else {
            print("2")
            textField.setUnderLine(color: UIColor(named: "MainColor1")!)
            return true
        }
        
    }
    func changBottomColor(textField : UITextField) {
        print("12")
//        textField.setUnderLine(color: UIColor.red)
        self.view.layoutIfNeeded()
        
//        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setUnderLine(color: UIColor(named: "MainColor2")!)
        if errorColor == true {
            print("3")
            textField.setUnderLine(color: UIColor.systemRed)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let keyboardFrame = notinfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let heiget = -(keyboardFrame.size.height - self.view.safeAreaInsets.bottom + 20)
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
                $0.bottom.equalTo(-30)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}
