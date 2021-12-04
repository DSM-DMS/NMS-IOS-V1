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
import AudioToolbox

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
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .systemBackground
        $0.separatorStyle = .none
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
        mainTableView.register(MainPostTableViewCell.self, forCellReuseIdentifier: "cell2")
        mainTableView.register(MainPostHasImageTableViewCell.self, forCellReuseIdentifier: "cell3")

        view.addSubview(mainBackView)
        view.addSubview(backNavigationBarView)
        mainBackView.addSubview(mainTableView)
        mainTableView.reloadData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        makeConstraint()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        makeNavigationBar()
    }
    
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.barTintColor =  UIColor(named: "MainColor1")

        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "\(store.list[indexNum].Title)"
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
        mainTableView.snp.makeConstraints  {
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.bottom.equalTo(0)
        }
    }
}
extension DetailPostViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        if store.list[indexNum].PostImage == nil {
            let Pcell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MainPostTableViewCell
            
            Pcell.reportButtonAction = { [unowned self] in
                AudioServicesPlaySystemSound(1520)
                Pcell.likeButton.isSelected.toggle()
                Pcell.likeButton.isSelected = revertBool(bool: Pcell.likeButton.isSelected)
            }
            Pcell.postTitleTextView.text = "\(store.list[indexNum].Title)"
            Pcell.postLocationLabel.text = "\(store.list[indexNum].LocationDate)"
            Pcell.mainPostTextView.text = "\(store.list[indexNum].Body)"
            Pcell.likeCountLabel.setTitle(" \(store.list[indexNum].LikeCount)", for: .normal)
            Pcell.commentCountLabel.text = "댓글 \(store.list[indexNum].CommentCount)"
            if store.list[indexNum].badge?.count == 1 {
                badgeSetting(title: "\(store.list[indexNum].badge![0])", target: Pcell.categorybadge)
            } else if store.list[indexNum].badge?.count == 2 {
                badgeSetting(title: "\(store.list[indexNum].badge![0])", target: Pcell.categorybadge)
                badgeSetting(title: "\(store.list[indexNum].badge![1])", target: Pcell.categorybadge2)
            }
            Pcell.selectedBackgroundView = bgColorView
            return Pcell
        }
        else {
            let Hcell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! MainPostHasImageTableViewCell
            
            Hcell.reportButtonAction = { [unowned self] in
                AudioServicesPlaySystemSound(1520)
                Hcell.likeButton.isSelected.toggle()
                Hcell.likeButton.isSelected = revertBool(bool: Hcell.likeButton.isSelected)
            }
            Hcell.postTitleTextView.text = "\(store.list[indexNum ].Title)"
            Hcell.postLocationLabel.text = "\(store.list[indexNum].LocationDate)"
            Hcell.mainPostTextView.text = "\(store.list[indexNum].Body)"
            Hcell.likeCountLabel.setTitle(" \(store.list[indexNum].LikeCount)", for: .normal)
            Hcell.commentCountLabel.text = "댓글 \(store.list[indexNum].CommentCount)"
            if store.list[indexNum].badge?.count == 1 {
                badgeSetting(title: "\(store.list[indexNum].badge![0])", target: Hcell.categorybadge)
            } else if store.list[indexNum].badge?.count == 2 {
                badgeSetting(title: "\(store.list[indexNum].badge![0])", target: Hcell.categorybadge)
                badgeSetting(title: "\(store.list[indexNum].badge![1])", target: Hcell.categorybadge2)
            }
            
            Hcell.PostImage.image = store.list[indexNum].PostImage
            Hcell.selectedBackgroundView = bgColorView
            return Hcell
            
        }
        
    }
    func revertBool(bool : Bool) -> Bool {
        if bool == false {
            return true
        } else {
            return false
        }
    }
}
