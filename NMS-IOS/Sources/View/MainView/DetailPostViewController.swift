//
//  DetailPostViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/01.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa


class DetailPostViewController: UIViewController {
    
    var indexNum = 1
    let mainVC = MainViewController()
    let bag = DisposeBag()
    let store = MainPost()

    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let backNavigationBarView  = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
        view.addSubview(mainBackView)
        view.addSubview(backNavigationBarView)
        makeConstraint()
        
            }
    override func viewDidAppear(_ animated: Bool) {
        makeNavigationBar()
    }
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "\(store.list[indexNum - 1].Title)"
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
    }
}
