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
    let disposeBag = DisposeBag()

    let mainView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    let loginButton = UIButton().then {
        
        $0.setTitle("LOGIN", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 25.5
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
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    let pwtextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: " PASSWORD",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "MainColor2")!]
        )
        $0.tintColor = UIColor(named: "MainColor1")
        $0.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainBackColor1")
        setSearchController()
        setAddSubView()
        setMain()
        setLayout()
    }
    func setMain() {
        saveIdButton.rx.tap
            .bind {
                self.saveIdButton.isSelected.toggle()
                
            }.disposed(by: disposeBag)
    }
    override func viewDidLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: idTextField.frame.height + 3, width: idTextField.frame.width + 8, height: 1)
        bottomLine.backgroundColor = UIColor(named: "MainColor2")?.cgColor
        idTextField.borderStyle = UITextField.BorderStyle.none
        idTextField.layer.addSublayer(bottomLine)
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: idTextField.frame.height + 3, width: pwtextField.frame.width + 8, height: 1)
        bottomLine1.backgroundColor = UIColor(named: "MainColor2")?.cgColor
        pwtextField.borderStyle = UITextField.BorderStyle.none
        pwtextField.layer.addSublayer(bottomLine1)
    }
    override func viewWillAppear(_ animated: Bool) {
        setSearchController()
    }
    func setAddSubView() {
        self.idTextField.delegate = self
        view.addSubview(mainView)
        view.addSubview(idTextField)
        view.addSubview(saveIdButton)
        view.addSubview(pwtextField)
        view.addSubview(loginButton)
    }
    func setLayout() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(637)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
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
        pwtextField.snp.makeConstraints {
            $0.width.equalTo(348)
            $0.height.equalTo(35)
            $0.centerY.equalTo(self.mainView).offset(-40)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        // make sure the result is under 16 characters
        return updatedText.count <= 10
    }
}
