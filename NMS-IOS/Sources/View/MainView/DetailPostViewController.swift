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

class DetailPostViewController: UIViewController, ConstraintRelatableTarget {
    
    var indexNum = 1
    var noticeId = 1
    var frameSize = 300
    var lastRowInLastSection = 0
    var lastSection = 0
    var isTableViewSelected = false
    let mainVC = MainViewController()
    var notice = [Notices]()
    let NoticeClass = NoticeApi()
    let bag = DisposeBag()
    let store = MainPost()
    let comment = MainComment()
    
    var viewHeightConstraint: Constraint!
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let backNavigationBarView  = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor1")
    }
    
    let mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .systemBackground
        $0.separatorStyle = .none
        
    }
    let PostTableView = UITableView().then {
        $0.backgroundColor = .systemBackground
        $0.separatorStyle = .none
    }
    let inputTextFieldView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    let inputUserImage = UIImageView().then {
        $0.image = UIImage(named: "noImage")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    let inputTextField = UITextField().then {
        $0.borderStyle = .none
        $0.placeholder = "댓글을 입력하세요"
        $0.tintColor = .gray
    }
    let inputTextFieldBorderView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor(named: "MainColor2")?.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    let sendButton = UIButton().then {
        $0.setTitle("개시", for: .normal)
        $0.setTitleColor(UIColor(named: "MainColor1"), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
        
        mainTableView.register(MainCommentTableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.register(ReplyCommentTableViewCell.self, forCellReuseIdentifier: "cell1")
        mainTableView.register(MainPostTableViewCellHeader.self, forHeaderFooterViewReuseIdentifier: "cell2")
        mainTableView.register(MainPostHasImageTableViewCellHeader.self, forHeaderFooterViewReuseIdentifier: "cell3")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        
        view.addSubview(mainBackView)
        mainBackView.addSubview(inputTextFieldView)
        inputTextFieldView.addSubview(inputUserImage)
        inputUserImage.layer.cornerRadius = 17.5
        inputTextFieldBorderView.layer.cornerRadius = 17.5
        inputTextFieldView.addSubview(inputTextFieldBorderView)
        inputTextFieldBorderView.addSubview(inputTextField)
        inputTextFieldBorderView.addSubview(sendButton)
        view.addSubview(backNavigationBarView)
        mainBackView.addSubview(mainTableView)
        mainTableView.reloadData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        makeConstraint()
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
        makeNavigationBar()
    }
    
    func makeNavigationBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title =  "\(self.notice[indexNum].title)"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func bind() {
        sendButton.rx.tap.bind { [self] in
            if (self.inputTextField.text == "") {
                return
            }
            else {
                NoticeClass.postComment(content: self.inputTextField.text ?? "이거 에러남", noticeID: noticeId).subscribe(onNext: { statusCode in
                    switch statusCode {
                    case .success:
                        print("2412341343030550304-02950352950-0-5290-59320-5923-59 success!!")
                        self.NoticeClass.allNoticeGet()
                            .subscribe(onNext: { noticeData, statusCodes in
                                switch statusCodes {
                                case .success:
                                    self.notice = noticeData!.notices
                                    self.inputTextField.text = ""

                                    scrollToBottom()
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

//                let lastindexPath = IndexPath(row: self.comment.list.count, section: 0)
//                //                chatDatas.append(chatStringTextView.text)
//                self.comment.list.append(DetailCommentDume(commentHashtagBool: false, id: 1, userName: "장성헤(마이스터부)", userImage: nil, locationDate: "방금 전", commentBody: self.inputTextField.text))
//                self.inputTextField.text = ""
//                self.mainTableView.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
//                self.mainTableView.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }.disposed(by: bag)
    }
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let keyboardFrame = notinfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let heiget = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.inputTextFieldView.snp.updateConstraints {
                $0.bottom.equalTo(-heiget)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.inputTextFieldView.snp.updateConstraints() {
                $0.bottom.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    func makeConstraint() {
        mainBackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        inputTextFieldView.snp.makeConstraints {
            $0.width.equalTo(self.view.frame.width)
            $0.height.equalTo(60)
            $0.bottom.equalTo(0)
            $0.centerX.equalTo(self.view).offset(0)
        }
        inputUserImage.snp.makeConstraints {
            $0.width.equalTo(35)
            $0.height.equalTo(35)
            $0.left.equalTo(20)
            $0.centerY.equalTo(self.inputTextFieldView).offset(0)
        }
        inputTextFieldBorderView.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.left.equalTo(self.inputUserImage.snp.right).offset(10)
            $0.right.equalTo(-20)
            $0.centerY.equalTo(self.inputTextFieldView).offset(0)
        }
        sendButton.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.width.equalTo(40)
            $0.centerY.equalTo(self.inputTextFieldView).offset(0)
        }
        inputTextField.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(self.sendButton.snp.left).offset(-10)
            $0.centerY.equalTo(self.inputTextFieldView).offset(0)
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
            $0.bottom.equalTo(self.inputTextFieldView.snp.top)
        }
        
    }
}
extension DetailPostViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == PostTableView {
            lastRowInLastSection = 1
            return 1
        } else {
            lastRowInLastSection = notice[indexNum].comments?.count ?? 0 + 1
            return notice[indexNum].comments?.count ?? 0 + 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == PostTableView {
            lastSection = 1
            return 1
        } else {
            if notice[indexNum].comments?[section].reply_count  == 0 {
                lastSection = 1
                return 1
            } else if notice[indexNum].comments?[section].reply_count  != 0 {
                lastSection = notice[indexNum].comments?[section].reply_count ?? 0 + 1
                return notice[indexNum].comments?[section].reply_count ?? 0 + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainCommentTableViewCell
            //            Ccell.userImage.image = comment.list[indexPath.row - 1].userImage ?? UIImage(named: "noImage")
            Ccell.useridLabel.text = notice[indexNum].comments?[indexPath.section].writer.name
            Ccell.commentLocationLabel.text = notice[indexNum].comments?[indexPath.section].created_date
            Ccell.commentLabel.text = notice[indexNum].comments?[indexPath.section].content
            return Ccell
        }
        else {
            let CBcell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ReplyCommentTableViewCell
            //            CBcell.userImage.image = comment.list[indexPath.row - 1].userImage ?? UIImage(named: "noImage")
            CBcell.useridLabel.text = notice[indexNum].comments?[indexPath.section].replies[indexPath.row - 1].writer.name
            CBcell.commentLocationLabel.text = notice[indexNum].comments?[indexPath.section].replies[indexPath.row - 1].created_date
            CBcell.commentLabel.text = notice[indexNum].comments?[indexPath.section].replies[indexPath.row - 1].content
            return CBcell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        if self.notice[indexNum].images?.count == 0 {
            let Pcell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell2") as! MainPostTableViewCellHeader
          
            DispatchQueue.global().async {
                
                let userUrl = URL(string: (self.notice[self.indexNum].writer.profile_url) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                let userImageData = try! Data(contentsOf: userUrl!)
                DispatchQueue.main.async {
                    Pcell.userImage.image = (UIImage(data: userImageData))
                }
            }
            print("------------\(String(describing: self.notice[indexNum].star))--------------------")
          
            Pcell.useridLabel.text = "\(self.notice[indexNum].writer.name)"
            Pcell.postTitleTextView.text = "\(self.notice[indexNum].title)"
            Pcell.postLocationLabel.text = "\(self.notice[indexNum].updated_date )"
            Pcell.mainPostTextView.text = "\(self.notice[indexNum].content )"
            Pcell.likeCountLabel.setTitle(" \(self.notice[indexNum].star_count )", for: .normal)
            Pcell.commentCountLabel.text = "댓글 \(self.notice[indexNum].comment_count)"
            if self.notice[indexNum].targets?.count == 1 {
                badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexNum].targets![0] )"), target: Pcell.categorybadge)
            } else if self.notice[indexNum].targets?.count == 2 {
                badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexNum].targets![0] )"), target: Pcell.categorybadge)
                badgeSetting(title:targetKoreanChanged(target:"\(self.notice[indexNum].targets![1] )"), target: Pcell.categorybadge2)
            }
            return Pcell
            
        } else {
            
            let Hcell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell3") as! MainPostHasImageTableViewCellHeader
            
            DispatchQueue.global().async {
                let userUrl = URL(string: (self.notice[self.indexNum].writer.profile_url) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                let userImageData = try! Data(contentsOf: userUrl!)
                DispatchQueue.main.async {
                    Hcell.userImage.image = (UIImage(data: userImageData))
                }
            }
            
            
            Hcell.useridLabel.text = "\(self.notice[indexNum].writer.name)"
            Hcell.postTitleTextView.text = "\(self.notice[indexNum].title)"
            Hcell.postLocationLabel.text = "\(self.notice[indexNum].updated_date )"
            Hcell.mainPostTextView.text = "\(self.notice[indexNum].content )"
            Hcell.likeCountLabel.setTitle(" \(self.notice[indexNum].star_count )", for: .normal)
            Hcell.commentCountLabel.text = "댓글 \(self.notice[indexNum].comment_count)"
            if self.notice[indexNum].targets?.count == 1 {
                badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexNum].targets![0] )"), target: Hcell.categorybadge)
            } else if self.notice[indexNum].targets?.count == 2 {
                badgeSetting(title: targetKoreanChanged(target:"\(self.notice[indexNum].targets![0] )"), target: Hcell.categorybadge)
                badgeSetting(title:targetKoreanChanged(target:"\(self.notice[indexNum].targets![1] )"), target: Hcell.categorybadge2)
            }
            DispatchQueue.global().async {
                let url = URL(string: (self.notice[self.indexNum].images![0]))
                let ImageData = try! Data(contentsOf: url!)
                DispatchQueue.main.async {
                    Hcell.PostImage.image = (UIImage(data: ImageData))
                }
            }
            return Hcell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Header 영역 크기 = 140(separator 상단) + 12(separator 하단)\
                if section == 0 {
                    if self.notice[indexNum].images?.count == 0  {
                        print("---------------------------")
                        frameSize = 250
                        print(frameSize)
                        return CGFloat(frameSize)
                    }
                    else {
                        frameSize = 500
                        print("---------------------------")
                        print(frameSize)
                        return CGFloat(frameSize)
                    }
                } else {
                    frameSize = 0
                    print("---------------------------")
                    print(frameSize)
                    return CGFloat(frameSize)
                }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0

    }
    func revertBool(noticeID : Int, bool : Bool) -> Bool {
        if bool == false {
            print("true")
            NoticeClass.likeStarGet(noticeID: noticeID).subscribe(onNext: { statusCode in
                switch statusCode {
                case .success:
                    print("likeStarGet success!!")
                    self.NoticeClass.allNoticeGet()
                        .subscribe(onNext: { noticeData, statusCodes in
                            switch statusCodes {
                            case .success:
                                self.notice = noticeData!.notices
                                
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
    func scrollToBottom(){
        DispatchQueue.main.async { [self] in
            print("---------------------------------------------------------------------------\(lastRowInLastSection)\(lastSection)")
              mainTableView.scrollToNearestSelectedRow(at: UITableView.ScrollPosition.bottom, animated: true)
          }
      }
}
