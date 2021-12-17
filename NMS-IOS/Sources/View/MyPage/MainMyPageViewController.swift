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
import Alamofire

class MainMyPageViewController: UIViewController {
    
    private var likePostCollectionView: CustomCollectionView!
    let myPage = MyPageApi()
    var staredNotice = [StaredNotice]()
    let bag = DisposeBag()
    
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
        $0.image = UIImage(named: "noimage")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    var useridLabel = UILabel().then {
        $0.text = "로딩중"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 14.0)
    }
    var emailLabel = UILabel().then {
        $0.text = "로딩중입니다."
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14.0)
        $0.textColor = .secondaryLabel
    }
    let editButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "awesome-pen"), for: .normal)
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
    
    func setcustomCollectionView() {
        likePostCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        likePostCollectionView.backgroundColor = .systemBackground
        likePostCollectionView.showsHorizontalScrollIndicator = false
        likePostCollectionView.showsVerticalScrollIndicator = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar()
        setcustomCollectionView()
        
        likePostCollectionView.register(LikePostCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        userImage.layer.cornerRadius = 25.5
        view.addSubview(mainBackView)
        mainBackView.addSubview(userImage)
        mainBackView.addSubview(useridLabel)
        mainBackView.addSubview(emailLabel)
        mainBackView.addSubview(editButton)
        mainBackView.addSubview(likepostlabel)
        mainBackView.addSubview(collectionTopLine)
        mainBackView.addSubview(likePostCollectionView)
        makeConstraint()
        likePostCollectionView.delegate = self
        likePostCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bind()
        setNavagationBar()
    }
    
    func bind() {
        myPage.myPageGet().subscribe(onNext: { myPageData, StatusCode in
            switch StatusCode {
            case .success:
                self.useridLabel.text = "\(myPageData?.gcn ?? "") \(myPageData?.name ?? "")"
                self.emailLabel.text = "\(myPageData?.email ?? "")"
                let userUrl = URL(string: (myPageData?.profile_url) ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image" )
                let userImageData = try! Data(contentsOf: userUrl!)
                self.userImage.image = (UIImage(data: userImageData))
                self.staredNotice =  myPageData!.stared_notice
                print(myPageData!.stared_notice.count)
                self.likePostCollectionView.reloadData()
            default:
                let alert = UIAlertController(title: "로딩에 실페했습니다. .", message: "네트워크 설정을 확인하세요", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "확인", style: .default) { (action) in
                }
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: bag)
        editButton.rx.tap.bind {
            let editMyProfileViewController = EditMyProfileViewController()
            self.navigationController?.pushViewController(editMyProfileViewController, animated: true)
        }.disposed(by: bag)
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
        likePostCollectionView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(0)
            $0.top.equalTo(self.collectionTopLine).offset(30)
        }
    }
    func setNavagationBar() {
        self.view.backgroundColor = .systemBackground
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainLogoBlue")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

extension MainMyPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return staredNotice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = likePostCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! LikePostCollectionViewCell
        
        
        DispatchQueue.global().async {
            
            let url = URL(string: (self.staredNotice[indexPath.row].image ?? "https://dummyimage.com/500x500/e5e5e5/000000&text=No+Image"))
            if let ImageData = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.postImageView.image = (UIImage(data: ImageData))
                }
            } else {
                DispatchQueue.main.async {
                    cell.postImageView.image = (UIImage(named: "noImage"))
                }
            }
        }
        cell.locationLabel.text = "\(self.staredNotice[indexPath.row].created_date)"
        cell.titleLabel.text = "\(self.staredNotice[indexPath.row].title)"
        return cell
    }
    
}
