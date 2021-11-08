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
    let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainBackColor1")
        $0.setTitle("다음", for: .normal)
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

        view.addSubview(nextButton)
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
<<<<<<< Updated upstream
            $0.bottom.equalTo(-50)
=======
            $0.centerY.equalTo(self.view).offset(350)
>>>>>>> Stashed changes
            $0.centerX.equalTo(self.view).offset(0)
        }
    }
    func setSearchController() {
        self.view.backgroundColor = UIColor.white
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "MainBackColor1")
    }
}
extension SecondSignUpViewController  {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
<<<<<<< Updated upstream
        let keyboardFrame = notinfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let heiget = -(keyboardFrame.size.height - self.view.safeAreaInsets.bottom + 50)
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.bottom.equalTo(heiget)
=======
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
                $0.centerY.equalTo(self.view).offset(100)
>>>>>>> Stashed changes
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.nextButton.snp.updateConstraints() {
<<<<<<< Updated upstream
                $0.bottom.equalTo(-50)
=======
                $0.centerY.equalTo(self.view).offset(350)
>>>>>>> Stashed changes
            }
            self.view.layoutIfNeeded()
        }
    }
<<<<<<< Updated upstream
=======
    
>>>>>>> Stashed changes
}
