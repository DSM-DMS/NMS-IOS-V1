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
    let gradeMenuButton = UIButton().then {
        $0.setTitle("학년별", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    let schoolMenuButton = UIButton().then {
        $0.setTitle("카테고리", for: .normal)
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
            self.InSchoolChangeTitle(title: "교내")
        })
        let outSchool = UIAction(title: "교내", handler: {_ in
            self.InSchoolChangeTitle(title: "교외")
        })
        let noneinschool = UIAction(title: "선택안함", handler: {_ in
            self.schoolMenuButton.setTitle("카테고리", for: .normal)
            self.schoolMenuButton.backgroundColor = .clear
            self.schoolMenuButton.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
            self.schoolMenuButton.layer.borderColor = UIColor(named: "MainColor2")?.cgColor
            self.schoolMenuButton.layer.borderWidth = 1
        })
        
        let nonegrade = UIAction(title: "선택안함", handler: {_ in
            self.gradeMenuButton.setTitle("학년별", for: .normal)
            self.gradeMenuButton.backgroundColor = .clear
            self.gradeMenuButton.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
            self.gradeMenuButton.layer.borderColor = UIColor(named: "MainColor2")?.cgColor
            self.gradeMenuButton.layer.borderWidth = 1
        })
        let grade1  = UIAction(title: "1학년", handler: {_ in
            self.GradeChangTitle(title: "1학년")
        })
        let grade2 = UIAction(title: "2학년", handler: {_ in
            self.GradeChangTitle(title: "2학년")
        })
        let grade3 = UIAction(title: "3학년", handler: {_ in
            self.GradeChangTitle(title: "3학년")
        })
        schoolMenuButton.showsMenuAsPrimaryAction = true
        schoolMenuButton.menu = UIMenu( options: .displayInline, children: [noneinschool, inSchool, outSchool])
        gradeMenuButton.showsMenuAsPrimaryAction = true
        gradeMenuButton.menu = UIMenu(options: .displayInline, children: [nonegrade, grade1, grade2, grade3])
    }
    func GradeChangTitle (title : String) {
        self.gradeMenuButton.setTitle(title, for: .normal)
        self.gradeMenuButton.backgroundColor = UIColor(named: "MainColor1")
        self.gradeMenuButton.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        self.gradeMenuButton.setTitleColor(UIColor.white, for: .normal)
        self.gradeMenuButton.layer.borderWidth = 0
    }
    func InSchoolChangeTitle(title : String) {
        self.schoolMenuButton.setTitle(title, for: .normal)
        self.schoolMenuButton.backgroundColor = UIColor(named: "MainColor1")
        self.schoolMenuButton.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 10.0)
        self.schoolMenuButton.setTitleColor(UIColor.white, for: .normal)
        self.schoolMenuButton.layer.borderWidth = 0
    }
}

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }


