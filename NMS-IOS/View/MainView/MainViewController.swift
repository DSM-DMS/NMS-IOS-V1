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
    
    let mainBackView = UIView().then {
        $0.backgroundColor = UIColor(named: "BackColor")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = UIColor(named: "BackColor")
        $0.separatorStyle = .none
        
    }
    let personButton = UIBarButtonItem().then {
        let personImage = UIImage(systemName: "person.fill")
        $0.image = personImage
        $0.tintColor = .label
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackColor")
        view.addSubview(mainBackView)
        
        mainBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainBackView.trailingAnchor.constraint(equalTo: self.view.c.trailingAnchor).isActive = true
        mainBackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainTableView.reloadData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainBackView.addSubview(mainTableView)
        
        setConstent()
        
        mainTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.register(MainPostTableViewCell.self, forCellReuseIdentifier: "cell2")
        setNavagationBar()
    }
    func setNavagationBar() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainLogoBlue")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "BackColor")!.withAlphaComponent(0.1)
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "BackColor")
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
            
            let Pcell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MainPostTableViewCell
            
            Pcell.postTitleTextView.text = "\(store.list[indexPath.row - 1].Title)"
            Pcell.postLocationLabel.text = "\(store.list[indexPath.row - 1].LocationDate)"
            Pcell.mainPostTextView.text = "\(store.list[indexPath.row - 1].Body)"
            Pcell.likeCountLabel.setTitle(" \(store.list[indexPath.row - 1].LikeCount)", for: .normal)
            Pcell.commentCountLabel.text = "댓글 \(store.list[indexPath.row - 1].CommentCount)"
            if store.list[indexPath.row - 1].PostImage != nil {
                Pcell.PostImage.image = store.list[indexPath.row - 1].PostImage
                
                Pcell.addSubview(Pcell.PostImage)
                Pcell.adjustUITextViewHeight(arg: Pcell.mainPostTextView)
                Pcell.PostImage.snp.makeConstraints {
                    $0.top.equalTo(Pcell.mainPostTextView.snp.bottom).offset(10)
                    $0.left.equalTo(20)
                    $0.right.equalTo(-20)
                    $0.height.equalTo(250)
                    $0.bottom.equalTo(-90)
                }
                Pcell.mainPostTextView.snp.makeConstraints {
                    $0.top.equalTo(Pcell.postTitleTextView.snp.bottom).offset(10)
                    $0.left.equalTo(20)
                    $0.right.equalTo(-20)
                    $0.bottom.equalTo(-250 - 100)
                }
            } else {
                Pcell.mainPostTextView.snp.makeConstraints {
                    $0.top.equalTo(Pcell.postTitleTextView.snp.bottom).offset(20)
                    $0.left.equalTo(20)
                    $0.right.equalTo(-20)
                    $0.bottom.equalTo(-90)
                }
            }
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            Pcell.selectedBackgroundView = bgColorView
            return Pcell
        }
        
    }
}
