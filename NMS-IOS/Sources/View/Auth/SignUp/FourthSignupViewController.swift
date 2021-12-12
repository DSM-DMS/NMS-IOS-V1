//
//  FourthSignupViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/11.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class FourthSignupViewController: UIViewController {
    
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
    let passWordField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 비밀번호를 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let rePassWordField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " 다시 한번 입력하세요",
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
        setMain()
        passWordField.delegate = self
        rePassWordField.delegate = self
        setSearchController()
        setAddSubView()
        setConstent()
        setMain()
        // Do any additional setup after loading the view.
    }
    func setAddSubView() {
        view.addSubview(signUpLabel)
        view.addSubview(passWordField)
        view.addSubview(rePassWordField)
        view.addSubview(nextButton)
    }
    
    func setConstent() {

        signUpLabel.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(30)
            $0.top.equalTo(100)
            $0.centerX.equalTo(self.view).offset(0)
        }
       
        passWordField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(200)
            $0.centerX.equalTo(self.view).offset(0)
        }
        rePassWordField.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(35)
            $0.top.equalTo(280)
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
    override func viewWillAppear(_ animated: Bool) {
        setSearchController()
    }
    override func viewDidLayoutSubviews() {
        passWordField.setUnderLine(color: UIColor(named: "MainColor2")!)
        rePassWordField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    func setMain() {
        nextButton.rx.tap.bind {
            let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in

                let editorViewController = MainViewController()
                let navEditorViewController: UINavigationController = UINavigationController(rootViewController: editorViewController)
                navEditorViewController.modalPresentationStyle = .fullScreen
                self.present(navEditorViewController, animated: true, completion: nil)

            }
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    


}

extension FourthSignupViewController : UITextFieldDelegate {
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
