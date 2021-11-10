//
//  MainPostTableViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MainPostTableViewCell: UITableViewCell {

    var userImage = UIImageView().then {
        $0.image = UIImage(named: "noImage")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    var useridLabel = UILabel().then {
        $0.text = "장성혜(마이스터부)"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
    }
    var postLocationLabel = UILabel().then {
        $0.text = "2021년 10월 20일(화) 12:20"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 10.0)
        $0.textColor = .secondaryLabel
    }
    var postTitleTextView = UILabel().then {
        $0.text = " 얘들아 급식 알려줄게"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
    }
    
    var mainPostTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.textContainer.maximumNumberOfLines = 6
        $0.isEditable = false
        $0.isSelectable = false
        $0.textContainer.lineBreakMode = .byTruncatingTail
        $0.text = "오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살 스테이크폭찹 등등 오늘의 급식은 백미밥 돈육 김치찌개 부들 어묵볶음 돌자반 계란후라이 사과 단호박브로콜리스프 해산물스파게티 목살스테이크폭찹 등등  "
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        adjustUITextViewHeight(arg: mainPostTextView)
        contentView.addSubview(userImage)
        userImage.layer.cornerRadius = 18
        contentView.addSubview(useridLabel)
        contentView.addSubview(postLocationLabel)
        contentView.addSubview(postTitleTextView)
        contentView.addSubview(mainPostTextView)
        userImage.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.top.equalTo(20)
            $0.left.equalTo(20)
        }
        useridLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(20)
            $0.top.equalTo(20)
            $0.left.equalTo(self.userImage).offset(45)
        }
        postLocationLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(18)
            $0.top.equalTo(40)
            $0.left.equalTo(self.userImage).offset(45)
        }
        postTitleTextView.snp.makeConstraints {
            $0.width.equalTo(320)
            $0.height.equalTo(18)
            $0.top.equalTo(self.postLocationLabel).offset(25)
            $0.left.equalTo(20)
        }
        mainPostTextView.snp.makeConstraints {
            
//            $0.height.equalTo(self.mainPostTextView.textContainer.maximumNumberOfLines * 15)
            $0.top.equalTo(self.postTitleTextView).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
}


