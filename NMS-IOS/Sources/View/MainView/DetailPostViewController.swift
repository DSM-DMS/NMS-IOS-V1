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
    var noticeId = 1
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
    
    let mainTableView = UITableView().then {
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
        mainTableView.register(MainPostTableViewCell.self, forCellReuseIdentifier: "cell2")
        mainTableView.register(MainPostHasImageTableViewCell.self, forCellReuseIdentifier: "cell3")
        
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
        self.navigationItem.title =  "\(store.list[indexNum].Title)"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func bind() {
        
        sendButton.rx.tap.bind { [self] in
            if (self.inputTextField.text == "") {
                return
            }
            else {
                self.NoticeClass.allNoticeGet().subscribe(onNext: { noticeSucces, statusCode in
                    
                }).disposed(by: bag)
                let lastindexPath = IndexPath(row: self.comment.list.count, section: 0)
                //                chatDatas.append(chatStringTextView.text)
                self.comment.list.append(DetailCommentDume(commentHashtagBool: false, id: 1, userName: "장성헤(마이스터부)", userImage: nil, locationDate: "방금 전", commentBody: self.inputTextField.text))
                self.inputTextField.text = ""
                self.mainTableView.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
                self.mainTableView.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
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
        return notice[indexNum].comments?.count ?? 0 + 1
    }
    // it is crash
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notice[indexNum].comments?[0].reply_count  == 0 {
            return 1
        }
        else if notice[indexNum].comments?[section - 1].reply_count  == 0 {
            return 1
        } else if notice[indexNum].comments?[section - 1].reply_count  != 0 {
            return notice[indexNum].comments?[section - 1].reply_count ?? 0 + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexNum :\(indexNum)")
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
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
}
