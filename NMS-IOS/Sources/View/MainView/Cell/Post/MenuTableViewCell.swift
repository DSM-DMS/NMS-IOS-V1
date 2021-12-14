//
//  menuTableViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MenuTableViewCell: UITableViewCell {
    
    let disposebag = DisposeBag()
    let NoticeClass = NoticeApi()
    let bag = DisposeBag()

    let gradeMenuButton = UIButton().then {
        $0.setTitle("학년별 ", for: .normal)
        $0.setImage(#imageLiteral(resourceName: "Icon ionic-ios-arrow-down"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    let schoolMenuButton = UIButton().then {
        $0.setTitle("카테고리 ", for: .normal)
        $0.setImage(#imageLiteral(resourceName: "Icon ionic-ios-arrow-down"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.borderWidth = 1
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(gradeMenuButton)
        contentView.addSubview(schoolMenuButton)
        setUI()
        gradeMenuButton.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(20)
            $0.left.equalTo(88)
            $0.centerY.equalTo(self.contentView).offset(0)
        }
        schoolMenuButton.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(20)
            $0.left.equalTo(15)
            $0.centerY.equalTo(self.contentView).offset(0)
        }
        gradeMenuButton.rx.tap.bind {
            print("gradeMenuButton tap")
        }.disposed(by: disposebag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setUI() {
        
        let inSchool = UIAction(title: "교내", handler: {_ in
            self.changeTitle(title: "교내 ", target: self.schoolMenuButton)
            self.NoticeClass.targetNoticeGet(target: "SCHOOL").subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    
                    MainViewController().notice = noticeData!.notices
                    MainViewController().noticeDataCount = noticeData!.notice_count
                    MainViewController().mainTableView.reloadData()
                    print("------devORnotice-----\(devORnotice)")
                    devORnotice = false
                    print("------devORnotice-----\(devORnotice)")
                default: break
                }
            }).disposed(by: self.bag)
        })
        let outSchool = UIAction(title: "교외", handler: {_ in
            self.changeTitle(title: "교외 ", target: self.schoolMenuButton)
            self.NoticeClass.DevTargetNoticeGet(target: "SUBURBS").subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    MainViewController().devNotice = noticeData!.notices
                    MainViewController().noticeDataCount = noticeData!.notice_count
                    print("------devORnotice-----\(devORnotice)")
                    devORnotice = true
                    print("------devORnotice-----\(devORnotice)")
                    MainViewController().mainTableView.reloadData()
                    
                default: break
                }
            }).disposed(by: self.bag)
        })
        let noneinschool = UIAction(title: "선택안함", handler: {_ in
            self.noneSelectTitle(title: "카테고리 ", target: self.schoolMenuButton)
            print("------devORnotice-----\(devORnotice)")
            devORnotice = false
        })
        let nonegrade = UIAction(title: "선택안함", handler: {_ in
            self.noneSelectTitle(title: "학년별 ", target: self.gradeMenuButton)
        })
        let grade1  = UIAction(title: "1학년", handler: {_ in
            self.changeTitle(title: "1학년 ", target: self.gradeMenuButton)
            self.NoticeClass.targetNoticeGet(target: "GRADE_FIRST").subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    print("------chaang")
                    MainViewController().notice = noticeData!.notices
                    MainViewController().noticeDataCount = noticeData!.notice_count
                    MainViewController().mainTableView.reloadData()
                default: break
                }
            }).disposed(by: self.bag)
        })
        let grade2 = UIAction(title: "2학년", handler: {_ in
            self.changeTitle(title: "2학년 ", target: self.gradeMenuButton)
            self.NoticeClass.targetNoticeGet(target: "GRADE_SECOND").subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    MainViewController().notice = noticeData!.notices
                    MainViewController().noticeDataCount = noticeData!.notice_count
                    MainViewController().mainTableView.reloadData()
                default: break
                }
            }).disposed(by: self.bag)
        })
        let grade3 = UIAction(title: "3학년", handler: {_ in
            self.changeTitle(title: "3학년 ", target: self.gradeMenuButton)
            self.NoticeClass.targetNoticeGet(target: "GRADE_THIRD").subscribe(onNext: { noticeData, statusCodes in
                switch statusCodes {
                case .success:
                    MainViewController().notice = noticeData!.notices
                    MainViewController().noticeDataCount = noticeData!.notice_count
                    MainViewController().mainTableView.reloadData()
                default: break
                }
            }).disposed(by: self.bag)
        })
        schoolMenuButton.showsMenuAsPrimaryAction = true
        schoolMenuButton.menu = UIMenu( options: .displayInline, children: [noneinschool, inSchool, outSchool])
        gradeMenuButton.showsMenuAsPrimaryAction = true
        gradeMenuButton.menu = UIMenu(options: .displayInline, children: [nonegrade, grade1, grade2, grade3])
    }
    func noneSelectTitle(title : String, target : UIButton) {
        target.setTitle(title, for: .normal)
        target.setImage(#imageLiteral(resourceName: "Icon ionic-ios-arrow-down"), for: .normal)
        target.backgroundColor = .clear
        target.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
        target.layer.borderColor = UIColor(named: "MainColor2")?.cgColor
        target.layer.borderWidth = 1
    }
    func changeTitle(title : String, target : UIButton) {
        target.setTitle(title, for: .normal)
        target.backgroundColor = UIColor(named: "MainColor1")
        target.setImage(#imageLiteral(resourceName: "cancleXICon"), for: .normal)
        target.semanticContentAttribute = .forceRightToLeft
        target.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        target.setTitleColor(UIColor.white, for: .normal)
        target.layer.borderWidth = 0
        
    }
}
