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
import AudioToolbox

class MainViewController: UIViewController {
    
    let store = MainPost()
    var notice = [Notices]()
    let NoticeClass = NoticeApi()
    let bag = DisposeBag()
    var noticeDataCount =  0
   
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
        NoticeClass.allNoticeGet()
            .subscribe(onNext: { noticeData, statusCodes in
            switch statusCodes {
            case .success:
                self.notice = noticeData!.notices
                self.noticeDataCount = noticeData!.notice_count
                print("-\(noticeData!.notice_count)-")
                self.mainTableView.reloadData()
            default:
                print("Not")
            }
        }).disposed(by: bag)

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
    override func viewDidAppear(_ animated: Bool) {

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
        return 1 + noticeDataCount
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
                Pcell.mainPostTextView.textContainer.maximumNumberOfLines = 6
                Pcell.reportButtonAction = { [unowned self] in
                    AudioServicesPlaySystemSound(1520)
                    Pcell.likeButton.isSelected.toggle()
                    Pcell.likeButton.isSelected = revertBool(bool: Pcell.likeButton.isSelected)
                }
                Pcell.reportCommentButtonAction = {
                    AudioServicesPlaySystemSound(1520)
                    let DetailPostViewController = DetailPostViewController()
                    DetailPostViewController.indexNum = indexPath.row - 1
                    self.navigationController?.pushViewController(DetailPostViewController, animated: true)
                }
                Pcell.postTitleTextView.text = "\(self.notice[indexPath.row - 1].title )"
                Pcell.postLocationLabel.text = "\(self.notice[indexPath.row - 1].updated_date )"
                Pcell.mainPostTextView.text = "\(self.notice[indexPath.row - 1].content )"
                Pcell.likeCountLabel.setTitle(" \(self.notice[indexPath.row - 1].star_count)", for: .normal)
                Pcell.commentCountLabel.text = "댓글 \(self.notice[indexPath.row - 1].comment_count)"
                if self.notice[indexPath.row - 1].targets?.count == 1 {
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![0] )", target: Pcell.categorybadge)
                } else if self.notice[indexPath.row - 1].targets?.count == 2 {
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![1] )", target: Pcell.categorybadge)
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![1] )", target: Pcell.categorybadge2)
                }
                Pcell.selectedBackgroundView = bgColorView
                return Pcell
            }
            else {
                let Hcell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! MainPostHasImageTableViewCell
                Hcell.mainPostTextView.textContainer.maximumNumberOfLines = 6
                Hcell.reportButtonAction = { [unowned self] in
                    AudioServicesPlaySystemSound(1520)
                    Hcell.likeButton.isSelected.toggle()
                    Hcell.likeButton.isSelected = revertBool(bool: Hcell.likeButton.isSelected)
                }
                Hcell.reportCommentButtonAction = {
                    AudioServicesPlaySystemSound(1520)
                    let DetailPostViewController = DetailPostViewController()
                    DetailPostViewController.indexNum = indexPath.row - 1
                    self.navigationController?.pushViewController(DetailPostViewController, animated: true)
                }
                Hcell.postTitleTextView.text = "\(self.notice[indexPath.row - 1].title)"
                Hcell.postLocationLabel.text = "\(self.notice[indexPath.row - 1].updated_date )"
                Hcell.mainPostTextView.text = "\(self.notice[indexPath.row - 1].content )"
                Hcell.likeCountLabel.setTitle(" \(self.notice[indexPath.row - 1].star_count )", for: .normal)
                Hcell.commentCountLabel.text = "댓글 \(self.notice[indexPath.row - 1].comment_count)"
                if self.notice[indexPath.row - 1].targets?.count == 1 {
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![0] )", target: Hcell.categorybadge)
                } else if self.notice[indexPath.row - 1].targets?.count == 2 {
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![1] )", target: Hcell.categorybadge)
                    badgeSetting(title: "\(self.notice[indexPath.row - 1].targets![1] )", target: Hcell.categorybadge2)
                }
                if self.notice[indexPath.row - 1].images?[0] == nil {
                    let url2 = URL(string: "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image")!
                    let ImageData = try! Data(contentsOf: url2)
                    Hcell.PostImage.image = (UIImage(data: ImageData))
                } else {
                    let url = URL(string: (self.notice[indexPath.row - 1].images?[0]) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                    let ImageData = try! Data(contentsOf: url!)
                    Hcell.PostImage.image = (UIImage(data: ImageData))
                }
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
