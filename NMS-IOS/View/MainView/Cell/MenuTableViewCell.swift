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
    
    let gradeMenuButton = UIButton().then {
        $0.setTitle("학년별", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor1")
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 16.0)
        $0.setTitleColor(UIColor(named: "MainColor1"), for: .normal)
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.layer.borderColor = UIColor(named: "MainColor1")?.cgColor
        $0.layer.borderWidth = 2
        
    }
    
    let schoolMenuButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(gradeMenuButton)
        gradeMenuButton.snp.makeConstraints {
            $0.width.equalTo(110)
            $0.height.equalTo(110)
            //            $0.centerY.equalTo(self.contentView).offset(-80)
            $0.left.equalTo(40)
            $0.centerX.equalTo(self.contentView).offset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setUI() {
        
        let grade1  = UIAction(title: "1학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 1학년 공통과정", for: .normal)
            print("1학년 공통과정")
        })
        let grade2 = UIAction(title: "2학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 2학년 임배디드 소프트웨어과", for: .normal)
            print("2학년 임배디드 소프트웨어과")
        })
        let grade3 = UIAction(title: "3학년", handler: {_ in
            self.gradeMenuButton.setTitle(" 3학년", for: .normal)
            print("3학년")
        })
        gradeMenuButton.setTitle(" 학년을 선택해주세요", for: .normal)
        gradeMenuButton.contentHorizontalAlignment = .left
        gradeMenuButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        gradeMenuButton.setTitleColor(UIColor(named: "MainColor2"), for: .normal)
        gradeMenuButton.menu = UIMenu(title: "학년을 선택해 주세요", options: .displayInline, children: [grade1, grade2, grade3])
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }

}
