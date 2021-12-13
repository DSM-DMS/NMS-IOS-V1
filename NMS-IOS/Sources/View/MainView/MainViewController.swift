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
    let refreshControl = UIRefreshControl()
    var noticeDataCount =  0
    var noticeIdNum = 1
    
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
        refreshControl.endRefreshing() // 초기화 - refresh 종료
        mainTableView.refreshControl = refreshControl
        personButton.rx.tap.bind {
            let mainMyPageViewController = MainMyPageViewController()
            self.navigationController?.pushViewController(mainMyPageViewController, animated: true)
        }.disposed(by: bag)
        view.backgroundColor = .systemBackground
        view.addSubview(mainBackView)
        let refreshLoading = PublishRelay<Bool>() // ViewModel에 있다고 가정
        refreshControl.rx.controlEvent(.allEvents)
            .bind(onNext: {
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    self.NoticeClass.allNoticeGet()
                        .subscribe(onNext: { noticeData, statusCodes in
                            switch statusCodes {
                            case .success:
                                self.notice = noticeData!.notices
                                self.noticeDataCount = noticeData!.notice_count
                                self.noticeIdNum = noticeData?.notice_count ?? 1
                                self.mainTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            default:
                                let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                                }
                                alert.addAction(defaultAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }).disposed(by: self.bag)
                    self.refreshControl.endRefreshing()
                    //                    refreshLoading.accept(true) // viewModel에서 dataSource업데이트 끝난 경우
                }
            }).disposed(by: bag)
        refreshLoading
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: bag)
        NoticeClass.allNoticeGet()
            .subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    self.notice = noticeData!.notices
                    self.noticeDataCount = noticeData!.notice_count
                    self.noticeIdNum = noticeData?.notice_count ?? 1
                    self.mainTableView.reloadData()
                default:
                    let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    }
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
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
            if self.notice[indexPath.row - 1].images?.count == 0 {
                let Pcell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MainPostTableViewCell
                Pcell.mainPostTextView.textContainer.maximumNumberOfLines = 6
                Pcell.reportButtonAction = { [unowned self] in
                    AudioServicesPlaySystemSound(1520)
                    Pcell.likeButton.isSelected.toggle()
                    Pcell.likeButton.isSelected = revertBool(noticeID: notice[indexPath.row - 1].notice_id, bool: Pcell.likeButton.isSelected)
                }
                Pcell.reportCommentButtonAction = {
                    AudioServicesPlaySystemSound(1520)
                    let DetailPostViewController = DetailPostViewController()
                    DetailPostViewController.indexNum = indexPath.row - 1
                    DetailPostViewController.noticeId = self.notice[indexPath.row - 1].notice_id
                    DetailPostViewController.notice = self.notice
                    DetailPostViewController.frameSize = Pcell.frameSize
                    self.navigationController?.pushViewController(DetailPostViewController, animated: true)
                }
                DispatchQueue.global().async {
                    let userUrl = URL(string: (self.notice[indexPath.row - 1].writer.profile_url) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                    let userImageData = try? Data(contentsOf: userUrl!)
                    DispatchQueue.main.async {
                        Pcell.userImage.image = (UIImage(data: userImageData!))
                    }
                }
                Pcell.likeButton.isSelected = self.notice[indexPath.row - 1].star ?? false
                Pcell.useridLabel.text = "\(self.notice[indexPath.row - 1].writer.name)"
                Pcell.postTitleTextView.text = "\(self.notice[indexPath.row - 1].title )"
                Pcell.postLocationLabel.text = "\(self.notice[indexPath.row - 1].updated_date )"
                Pcell.mainPostTextView.text = "\(self.notice[indexPath.row - 1].content )"
                Pcell.likeCountLabel.setTitle(" \(self.notice[indexPath.row - 1].star_count)", for: .normal)
                Pcell.commentCountLabel.text = "댓글 \(self.notice[indexPath.row - 1].comment_count)"
                if self.notice[indexPath.row - 1].targets?.count == 1 {
                    badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![0] )"), target: Pcell.categorybadge)
                } else if self.notice[indexPath.row - 1].targets?.count == 2 {
                    badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![0] )"), target: Pcell.categorybadge)
                    badgeSetting(title:targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![1] )"), target: Pcell.categorybadge2)
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
                    Hcell.likeButton.isSelected = revertBool(noticeID: notice[indexPath.row - 1].notice_id, bool: Hcell.likeButton.isSelected)
                }
                Hcell.reportCommentButtonAction = {
                    AudioServicesPlaySystemSound(1520)
                    let DetailPostViewController = DetailPostViewController()
                    DetailPostViewController.indexNum = indexPath.row - 1
                    DetailPostViewController.notice = self.notice
                    DetailPostViewController.noticeId = self.notice[indexPath.row - 1].notice_id
                    DetailPostViewController.frameSize = Hcell.frameSize
                    self.navigationController?.pushViewController(DetailPostViewController, animated: true)
                }
                DispatchQueue.global().async {
                    let userUrl = URL(string: (self.notice[indexPath.row - 1].writer.profile_url) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                    let userImageData = try! Data(contentsOf: userUrl!)
                    DispatchQueue.main.async {
                        Hcell.userImage.image = (UIImage(data: userImageData))
                    }
                    
                }
                Hcell.likeButton.isSelected = self.notice[indexPath.row - 1].star ?? false
                Hcell.useridLabel.text = "\(self.notice[indexPath.row - 1].writer.name)"
                Hcell.postTitleTextView.text = "\(self.notice[indexPath.row - 1].title)"
                Hcell.postLocationLabel.text = "\(self.notice[indexPath.row - 1].updated_date )"
                Hcell.mainPostTextView.text = "\(self.notice[indexPath.row - 1].content )"
                Hcell.likeCountLabel.setTitle(" \(self.notice[indexPath.row - 1].star_count )", for: .normal)
                Hcell.commentCountLabel.text = "댓글 \(self.notice[indexPath.row - 1].comment_count)"
                if self.notice[indexPath.row - 1].targets?.count == 1 {
                    badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![0] )"), target: Hcell.categorybadge)
                } else if self.notice[indexPath.row - 1].targets?.count == 2 {
                    badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![0] )"), target: Hcell.categorybadge)
                    badgeSetting(title:targetKoreanChanged(target:"\(self.notice[indexPath.row - 1].targets![1] )"), target: Hcell.categorybadge2)
                }
                DispatchQueue.global().async {
                    let url = URL(string: (self.notice[indexPath.row - 1].images![0]))
                    let ImageData = try! Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        Hcell.PostImage.image = (UIImage(data: ImageData))
                    }
                }
                
                Hcell.selectedBackgroundView = bgColorView
                return Hcell
            }
        }
    }
    func revertBool(noticeID : Int, bool : Bool) -> Bool {
        if bool == false {
            print("true")
            print("\(noticeID)")
            NoticeClass.likeStarGet(noticeID: noticeID).subscribe(onNext: { statusCode in
                switch statusCode {
                case .success:
                    print("likeStarGet success!!")
                    self.NoticeClass.allNoticeGet()
                        .subscribe(onNext: { noticeData, statusCodes in
                            switch statusCodes {
                            case .success:
                                self.notice = noticeData!.notices
                                self.noticeDataCount = noticeData!.notice_count
                                print("-\(noticeData!.notice_count)-")
                                self.mainTableView.reloadData()
                            default:
                                let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                                }
                                alert.addAction(defaultAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }).disposed(by: self.bag)
                    
                default:
                    let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    }
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }).disposed(by: bag)
            return true
        } else {
            print("false")
            NoticeClass.unLikeStarGet(noticeID: noticeID).subscribe(onNext: { statusCode in
                switch statusCode {
                case .success:
                    print("unLikeStarGet success!!")
                    self.NoticeClass.allNoticeGet()
                        .subscribe(onNext: { noticeData, statusCodes in
                            switch statusCodes {
                            case .success:
                                self.notice = noticeData!.notices
                                self.noticeDataCount = noticeData!.notice_count
                                print("-\(noticeData!.notice_count)-")
                                self.mainTableView.reloadData()
                            default:
                                let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                                }
                                alert.addAction(defaultAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }).disposed(by: self.bag)
                    
                default:
                    let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    }
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }).disposed(by: bag)
            
            return false
        }
    }
}
