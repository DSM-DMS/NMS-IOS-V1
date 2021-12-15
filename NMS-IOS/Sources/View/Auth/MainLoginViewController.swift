//
//  MainLoginViewController.swift
//  0Z-Project
//
//  Created by 김대희 on 2021/11/03.
//

import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

class MainLoginViewController: UIViewController {
    
    let Auth = AuthApi()
    
    let disposeBag = DisposeBag()
    let MainLogoImage = UIImageView().then {
        $0.image = UIImage(named: "MainLogoWhite")
        $0.backgroundColor = .clear
    }
    let mainView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    let saveIdButton = UIButton().then {
        let checkbox = UIImage(named: "fillCheck")
        let emptyCheckbox = UIImage(named:"emptyCheck")
        $0.setImage(emptyCheckbox, for: .selected)
        $0.setTitle("  아이디 저장", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
        $0.setImage(checkbox, for: .normal)
        $0.isSelected = false
        
    }
    let idTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " ID or Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!, NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Regular", size: 16.0)!]
        )
        $0.textColor = .black
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 16.0)
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let loginButton = UIButton().then {
        $0.showsMenuAsPrimaryAction = true
        $0.setTitle("LOGIN", for: .normal)
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 20.0)
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 25.5
    }
    let buttomJustLine = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor2")
    }
    let SignupMembership = UIButton().then {
        $0.setTitle("회원가입 하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
    }
    let FindingPassword = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
    }
    
    let pwtextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " PASSWORD",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!, NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Regular", size: 16.0)!]
            
        )
        $0.textColor = .black
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 16.0)
        $0.isSecureTextEntry = true
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor1")
        setSearchController()
        setAddSubView()
        setMain()
        setLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        idTextField.text = "0824dh@dsm.hs.kr"
        pwtextField.text = "qwe123!@"
    }
    func setMain() {
        loginButton.rx.tap.bind { [self] in
            if idTextField.text == nil || pwtextField.text == "" {
                print("No Resalt")
                return
            } else {
                print(Auth.login(email: idTextField.text, password: pwtextField.text).subscribe(onNext:  {res in
                    switch res {
                    case .success:
                        print("성공")
                        let editorViewController = MainViewController()
                        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: editorViewController)
                        navEditorViewController.modalPresentationStyle = .fullScreen
                        present(navEditorViewController, animated: true, completion: nil)
                    case .notFound:
                        let alert = UIAlertController(title: "아이디나 비밀번호가 일치하지 않습니다.", message: "다시 입력하세요", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        }
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)

                    case .fault:
                        let alert = UIAlertController(title: "로그인에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        }
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                        print("Not")
                    default:
                        let alert = UIAlertController(title: "로그인에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        }
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }

                }))
                

            }
                    }.disposed(by: disposeBag)
        saveIdButton.rx.tap
            .bind {
                self.saveIdButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        SignupMembership.rx.tap.bind {
            let firstSignUpViewController = FirstSignUpViewController()
            self.navigationController?.pushViewController(firstSignUpViewController, animated: true)
        }.disposed(by: disposeBag)
    }
    override func viewDidLayoutSubviews() {
        idTextField.setUnderLine(color: UIColor(named: "MainColor2")!)
        pwtextField.setUnderLine(color: UIColor(named: "MainColor2")!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchController()
    }
    func setAddSubView() {
        self.idTextField.delegate = self
        self.pwtextField.delegate = self
        view.addSubview(mainView)
        view.addSubview(MainLogoImage)
        view.addSubview(idTextField)
        view.addSubview(saveIdButton)
        view.addSubview(pwtextField)
        view.addSubview(buttomJustLine)
        view.addSubview(loginButton)
        view.addSubview(SignupMembership)
        view.addSubview(FindingPassword)
    }
    func setLayout() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(637)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }
        MainLogoImage.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(57)
            $0.top.equalTo(self.mainView).offset(-85)
            $0.left.equalTo(25)
        }
        loginButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.centerY.equalTo(self.view).offset(321)
            $0.centerX.equalTo(self.view).offset(0)
        }
        idTextField.snp.makeConstraints {
            $0.width.equalTo(348)
            $0.height.equalTo(35)
            $0.centerY.equalTo(self.mainView).offset(-150)
            $0.centerX.equalTo(self.view).offset(0)
        }
        saveIdButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(20)
            $0.centerY.equalTo(self.mainView).offset(-110)
            $0.left.equalTo(10)
            
        }
        SignupMembership.snp.makeConstraints {
            
            $0.centerY.equalTo(self.view).offset(380)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
            $0.centerX.equalTo(self.view).offset(-60)
        }
        FindingPassword.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(20)
            $0.centerY.equalTo(self.view).offset(380)
            $0.centerX.equalTo(self.view).offset(60)
        }
        pwtextField.snp.makeConstraints {
            $0.width.equalTo(348)
            $0.height.equalTo(35)
            $0.centerY.equalTo(self.mainView).offset(-40)
            $0.centerX.equalTo(self.view).offset(0)
        }
        buttomJustLine.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(15)
            $0.centerY.equalTo(self.view).offset(380)
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
    func setSearchController() {
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
extension MainLoginViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setUnderLine(color: UIColor(named: "MainColor1")!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.mainView.snp.updateConstraints() {
                $0.bottom.equalTo(-100)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.mainView.snp.updateConstraints() {
                $0.bottom.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }
    }
    }
