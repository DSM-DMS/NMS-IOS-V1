//
//  MainViewController.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/08.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    let store = MainPost()
    let bag = DisposeBag()
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .systemBackground
        $0.separatorStyle = .none
        
    }
    let personButton = UIBarButtonItem().then {
        let personImage = UIImage(systemName: "person.fill")
        $0.image = personImage
        $0.tintColor = .label
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        personButton.rx.tap.bind {
            let mainMyPageViewController = MainMyPageViewController()
            self.navigationController?.pushViewController(mainMyPageViewController, animated: true)
        }.disposed(by: bag)
        view.backgroundColor = .systemBackground
        view.addSubview(mainBackView)
        
        mainBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainBackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainBackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainTableView.reloadData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainBackView.addSubview(mainTableView)
        
        setConstent()
        
        mainTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.register(MainPostTableViewCell.self, forCellReuseIdentifier: "cell2")
        mainTableView.register(MainPostHasImageTableViewCell.self, forCellReuseIdentifier: "cell3")
        setNavagationBar()
    }
    func setNavagationBar() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainLogoBlue")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationItem.rightBarButtonItem = personButton
    }
    func setConstent() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(mainBackView.snp.top)
            $0.bottom.equalTo(mainBackView.snp.bottom)
            $0.left.equalTo(mainBackView.snp.left)
            $0.right.equalTo(mainBackView.snp.right)
        }
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + store.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            Ccell.selectedBackgroundView = bgColorView
            return Ccell
        } else {
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            if store.list[indexPath.row - 1].PostImage == nil {
                let Pcell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MainPostTableViewCell
                
                Pcell.reportButtonAction = { [unowned self] in
                    Pcell.likeButton.isSelected.toggle()
                    Pcell.likeButton.isSelected = revertBool(bool: Pcell.likeButton.isSelected)
                }
                Pcell.postTitleTextView.text = "\(store.list[indexPath.row - 1 ].Title)"
                Pcell.postLocationLabel.text = "\(store.list[indexPath.row - 1].LocationDate)"
                Pcell.mainPostTextView.text = "\(store.list[indexPath.row - 1].Body)"
                Pcell.likeCountLabel.setTitle(" \(store.list[indexPath.row - 1].LikeCount)", for: .normal)
                Pcell.commentCountLabel.text = "댓글 \(store.list[indexPath.row - 1].CommentCount)"
                if store.list[indexPath.row - 1].badge?.count == 1 {
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![0])", target: Pcell.categorybadge)
                } else if store.list[indexPath.row - 1].badge?.count == 2 {
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![0])", target: Pcell.categorybadge)
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![1])", target: Pcell.categorybadge2)
                }
                Pcell.selectedBackgroundView = bgColorView
                return Pcell
            }
            else {
                
                let Hcell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! MainPostHasImageTableViewCell

                Hcell.reportButtonAction = { [unowned self] in
                    Hcell.likeButton.isSelected.toggle()
                    Hcell.likeButton.isSelected = revertBool(bool: Hcell.likeButton.isSelected)
                }
                Hcell.postTitleTextView.text = "\(store.list[indexPath.row - 1 ].Title)"
                Hcell.postLocationLabel.text = "\(store.list[indexPath.row - 1].LocationDate)"
                Hcell.mainPostTextView.text = "\(store.list[indexPath.row - 1].Body)"
                Hcell.likeCountLabel.setTitle(" \(store.list[indexPath.row - 1].LikeCount)", for: .normal)
                Hcell.commentCountLabel.text = "댓글 \(store.list[indexPath.row - 1].CommentCount)"
                if store.list[indexPath.row - 1].badge?.count == 1 {
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![0])", target: Hcell.categorybadge)
                } else if store.list[indexPath.row - 1].badge?.count == 2 {
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![0])", target: Hcell.categorybadge)
                    badgeSetting(title: "\(store.list[indexPath.row - 1].badge![1])", target: Hcell.categorybadge2)
                }

                Hcell.PostImage.image = store.list[indexPath.row - 1].PostImage
                Hcell.selectedBackgroundView = bgColorView
                return Hcell

            }
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
