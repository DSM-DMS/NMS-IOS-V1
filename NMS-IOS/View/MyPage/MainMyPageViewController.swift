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
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar()
        
        view.addSubview(mainBackView)
        // Do any additional setup after loading the view.
        mainBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainBackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainBackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
