//
//  EditMyProfileViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/23.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class EditMyProfileViewController: UIViewController {
    
    let bag = DisposeBag()
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let backNavigationBarView  = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
    }
    let warningLabel = UILabel().then {
        $0.text = "* 닉네임과 프로필 사진만 변경이 가능합니다"
        $0.textAlignment = .center
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14.0)
    }
    var userImage = UIImageView().then {
        $0.image = UIImage(named: "DumeData-5")
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    let editButton = UIButton().then {
        $0.backgroundColor = .systemBackground
        $0.setImage(UIImage(named: "gray awesome-pen"), for: .normal)
        $0.tintColor = UIColor(named: "BackColor")
        $0.layer.cornerRadius = 12.5
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.borderWidth = 2
    }
    let nickNameTextField = UITextField().then {
        $0.textAlignment = .center
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25.5
        $0.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        $0.layer.borderWidth = 2
    }
    let changePasswordButton = UIButton().then {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "비밀번호 변경을 원하시나요?", attributes: underlineAttribute)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14.0)
        $0.setTitleColor(UIColor(named: "MainColor1"), for: .normal)
        $0.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    override func viewDidLayoutSubviews() {
        nickNameTextField.setUnderLine(color: UIColor(named: "MainColor2")!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
        
        nickNameTextField.delegate = self
        nickNameTextField.text = "김대희"
        changePasswordButton.rx.tap.bind {
            let firstChangPassWordViewController = FirstChangPassWordViewController()
            self.navigationController?.pushViewController(firstChangPassWordViewController, animated: true)
        }.disposed(by: bag)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addSubview(mainBackView)
        view.addSubview(backNavigationBarView)
        mainBackView.addSubview(warningLabel)
        mainBackView.addSubview(userImage)
        mainBackView.addSubview(editButton)
        mainBackView.addSubview(nextButton)
        mainBackView.addSubview(nickNameTextField)
        mainBackView.addSubview(changePasswordButton)
        makeConstraint()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "프로필 수정"
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
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.trailing.equalTo(30)
            $0.leading.equalTo(-30)
            $0.height.equalTo(20)
        }
        userImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.top.equalTo(self.warningLabel).offset(40)
            $0.centerX.equalTo(self.view).offset(0)
        }
        editButton.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.right.equalTo(self.userImage).offset(0)
            $0.bottom.equalTo(self.userImage).offset(0)
        }
        nickNameTextField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(35)
            $0.top.equalTo(200)
            $0.centerX.equalTo(self.view).offset(0)
        }
        nextButton.snp.makeConstraints {
            $0.width.equalTo(356)
            $0.height.equalTo(51)
            $0.bottom.equalTo(-35)
            $0.centerX.equalTo(self.view).offset(0)
        }
        changePasswordButton.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.trailing.equalTo(30)
            $0.leading.equalTo(-30)
            $0.bottom.equalTo(-10)
        }
    }
}
extension EditMyProfileViewController : UITextFieldDelegate {
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
