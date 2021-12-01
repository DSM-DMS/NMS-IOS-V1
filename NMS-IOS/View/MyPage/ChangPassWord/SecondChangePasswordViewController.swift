//
//  SecondChangePasswordViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/30.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SecondChangePasswordViewController: UIViewController {
    
    let bag = DisposeBag()
    var errorColor2 = Bool()
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let backNavigationBarView  = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
    }
    let newPasswordField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 새 비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let newCheckPasswordField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 비밀번호 확인",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.setTitle("변경하기", for: .normal)
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
        
        newPasswordField.delegate = self
        newCheckPasswordField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addSubview(mainBackView)
        view.addSubview(backNavigationBarView)
        mainBackView.addSubview(newPasswordField)
        mainBackView.addSubview(newCheckPasswordField)
        mainBackView.addSubview(nextButton)
        makeConstraint()
        
    }
    override func viewDidLayoutSubviews() {
        newPasswordField.setUnderLine(color: UIColor(named: "MainColor2")!)
        newCheckPasswordField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "새로운 비밀번호 생성"
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
        newPasswordField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(150)
            $0.centerX.equalTo(self.view).offset(0)
        }
        newCheckPasswordField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(225)
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
extension SecondChangePasswordViewController : UITextFieldDelegate {
    
    func bindButton() {
        nextButton.rx.tap.bind {
            
            if "\(self.newPasswordField.text ?? "NULL")" != "\(self.newCheckPasswordField.text ?? "NULL")" {
                self.errorColor2 = true
                print("--------\(self.newPasswordField.text ?? "NULL")")
                print("--------\(self.newCheckPasswordField.text ?? "NULL")")
                self.errorLabel.text = "비밀번호가 일치하지 않습니다."
                self.mainBackView.addSubview(self.errorLabel)
                self.newPasswordField.setUnderLine(color: UIColor.systemRed)
                self.newCheckPasswordField.setUnderLine(color: UIColor.systemRed)
                self.errorLabel.snp.makeConstraints {
                    $0.top.equalTo(self.newCheckPasswordField.snp.bottom).offset(8)
                    $0.width.equalTo(356)
                    $0.height.equalTo(15)
                    $0.centerX.equalTo(self.view).offset(0)
                }
            }
            if self.newPasswordField.text == "" {
                self.errorColor2 = true
                self.errorLabel.text = "새 비밀번호를 입력하세요"
                self.mainBackView.addSubview(self.errorLabel)
                self.newPasswordField.setUnderLine(color: UIColor.systemRed)
                self.errorLabel.snp.makeConstraints {
                    $0.top.equalTo(self.newCheckPasswordField.snp.bottom).offset(8)
                    $0.width.equalTo(356)
                    $0.height.equalTo(15)
                    $0.centerX.equalTo(self.view).offset(0)
                }
            }
            else if "\(self.newPasswordField.text ?? "NULL")" == "\(self.newCheckPasswordField.text ?? "NULL")" {
                let alert = UIAlertController(title: "비밀번호가 변경되었습니다", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    let editorViewController = MainViewController()
                    let navEditorViewController: UINavigationController = UINavigationController(rootViewController: editorViewController)
                    navEditorViewController.modalPresentationStyle = .fullScreen
                    self.present(navEditorViewController, animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            }
        }.disposed(by: bag )
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if errorColor2 == true {
            textField.setUnderLine(color: UIColor.systemRed)
            return true
        } else {
            textField.setUnderLine(color: UIColor(named: "MainColor1")!)
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setUnderLine(color: UIColor(named: "MainColor2")!)
        if errorColor2 == true {
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
