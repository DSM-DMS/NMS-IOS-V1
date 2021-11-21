//
//  MainMyPageViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/19.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MainMyPageViewController: UIViewController {
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let homeButton = UIBarButtonItem().then {
        $0.image = UIImage(named: "baseline_home")
        $0.tintColor = .label
        $0.style = UIBarButtonItem.Style.plain
    }
    
    var userImage = UIImageView().then {
        $0.image = UIImage(named: "DumeData-2")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    var useridLabel = UILabel().then {
        $0.text = "1301 김대희"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 14.0)
    }
    var emailLabel = UILabel().then {
        $0.text = "0824dh@dsm.hs.kr"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14.0)
        $0.textColor = .secondaryLabel
    }
    let editButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "awesome-pen"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 20.0)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 14
        $0.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        $0.layer.borderWidth = 2
    }
    let likepostlabel = UILabel().then {
        $0.text = "좋아하는 개시물"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14.0)
    }
    let collectionTopLine = UIView().then {
        $0.backgroundColor = .systemGray
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar()
        userImage.layer.cornerRadius = 25.5
        view.addSubview(mainBackView)
        mainBackView.addSubview(userImage)
        mainBackView.addSubview(useridLabel)
        mainBackView.addSubview(emailLabel)
        mainBackView.addSubview(editButton)
        mainBackView.addSubview(likepostlabel)
        mainBackView.addSubview(collectionTopLine)
        makeConstraint()
    }
    func makeConstraint() {
        mainBackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        userImage.snp.makeConstraints {
            $0.width.equalTo(51)
            $0.height.equalTo(51)
            $0.top.equalTo(20)
            $0.left.equalTo(20)
        }
        useridLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(16)
            $0.top.equalTo(25)
            $0.left.equalTo(self.userImage).offset(60)
        }
        emailLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(16)
            $0.top.equalTo(45)
            $0.left.equalTo(self.userImage).offset(60)
        }
        editButton.snp.makeConstraints {
            $0.width.equalTo(28)
            $0.height.equalTo(28)
            $0.top.equalTo(25)
            $0.right.equalTo(-20)
        }
        likepostlabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(125)
            $0.width.equalTo(150)
            $0.height.equalTo(20)
        }
        collectionTopLine.snp.makeConstraints {
            $0.leading.equalTo(5)
            $0.trailing.equalTo(-5)
            $0.height.equalTo(1)
            $0.top.equalTo(155)
        }
    }
    func setNavagationBar() {
        self.view.backgroundColor = .systemBackground
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainLogoBlue")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "baseline_home")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "baseline_home")
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.backBarButtonItem = homeButton
    }

}
