//
//  ReplyCommentTableViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/12/04.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class ReplyCommentTableViewCell: UITableViewCell {

    var userImage = UIImageView().then {
        $0.image = UIImage(named: "noImage")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    var useridLabel = UILabel().then {
        $0.text = "장성혜(마이스터부)"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 14.0)
    }
    var commentLocationLabel = UILabel().then {
        $0.text = "날짜가 들어가요"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 10.0)
        $0.textColor = .secondaryLabel
    }
    var commentLabel = UILabel().then {
        $0.text = " 제목이 들어가요"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(userImage)
        userImage.layer.cornerRadius = 18
        contentView.addSubview(useridLabel)
        contentView.addSubview(commentLocationLabel)
        contentView.addSubview(commentLabel)
        userImage.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.top.equalTo(20)
            $0.left.equalTo(40)
        }
        useridLabel.snp.makeConstraints {
//            $0.width.equalTo(150)
            $0.height.equalTo(20)
            $0.top.equalTo(20)
            $0.left.equalTo(self.userImage).offset(45)
        }
        commentLocationLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(18)
            $0.top.equalTo(40)
            $0.bottom.equalTo(-20)
            $0.left.equalTo(self.userImage).offset(45)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.height.equalTo(20)
            $0.width.equalTo(200)
            $0.left.equalTo(self.useridLabel.snp.right).offset(5)
        }

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
