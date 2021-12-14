//
//  DevPostTableViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/14.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa


class DevPostTableViewCell: UITableViewCell {

    var postLocationLabel = UILabel().then {
        $0.text = "2021년 10월 20일(화) 12:20"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
        $0.textColor = .secondaryLabel
    }
    
    let categorybadge = UIButton()
    let categorybadge2 = UIButton()
    
    var postTitleTextView = UILabel().then {
        $0.text = " 제목이 들어가요"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.0)
    }
    var postDateTextView = UILabel().then {
        $0.text = " DATE"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.0)
    }
    var mainPostTextView = UILabel().then {
        $0.backgroundColor = .clear
        $0.numberOfLines = 2
        $0.text = " 내용이 들어가요"
        $0.textColor = UIColor(named: "MainColor1")
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(postLocationLabel)
        contentView.addSubview(postTitleTextView)
        contentView.addSubview(categorybadge)
        contentView.addSubview(categorybadge2)
        contentView.addSubview(postDateTextView)
        contentView.addSubview(mainPostTextView)
        postLocationLabel.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(20)
            $0.top.equalTo(20)
            $0.left.equalTo(20)
        }
        postTitleTextView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(self.postLocationLabel).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        postDateTextView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(self.postTitleTextView).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        mainPostTextView.snp.makeConstraints {
            $0.top.equalTo(self.postDateTextView).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(50)
            $0.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
