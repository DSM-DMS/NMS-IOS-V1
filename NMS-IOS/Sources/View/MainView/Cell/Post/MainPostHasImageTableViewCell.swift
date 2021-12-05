//
//  MainPostHasImageTableViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/22.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MainPostHasImageTableViewCell: UITableViewCell {
    
    var reportButtonAction : (() -> ())?
    var reportCommentButtonAction : (() -> ())?
    
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
    
    let categorybadge = UIButton()
    let categorybadge2 = UIButton()
    
    var postTitleTextView = UILabel().then {
        $0.text = " 제목이 들어가요"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.0)
    }
    
    var mainPostTextView = UITextView().then {
        $0.backgroundColor = .clear

        $0.isEditable = false
        $0.isSelectable = false
        $0.textContainer.lineBreakMode = .byTruncatingTail
        $0.text = " 내용이 들어가요"
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
    }
    let lineheight = UIView().then {
        $0.backgroundColor = .secondaryLabel
    }
    let linewidth = UIView().then {
        $0.backgroundColor = .secondaryLabel
    }
    let linewidth2 = UIView().then {
        $0.backgroundColor = .secondaryLabel
    }
    let likeButton = UIButton().then {
        $0.setTitle(" 좋아요", for: .normal)
        $0.setImage(UIImage(named: "빈칸 좋아요"), for: .normal)
        $0.setImage(UIImage(named: "좋아요 버튼 Fill"), for: .selected)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
        $0.setTitleColor(.secondaryLabel, for: .normal)
        $0.isSelected = false
    }
    let commentButton = UIButton().then {
        $0.setTitle(" 댓글 작성", for: .normal)
        $0.setImage(UIImage(named: "빈칸 댓글"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
        $0.setTitleColor(.secondaryLabel, for: .normal)
    }
    let likeCountLabel = UIButton().then {
        $0.setTitle(" 34", for: .normal)
        $0.setImage(UIImage(named: "좋아요 파란색"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
        $0.setTitleColor(.label, for: .normal)
    }
    
    let commentCountLabel = UILabel().then {
        $0.text = "댓글 12"
        $0.textAlignment = .right
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 12.0)
    }
    let PostImage = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.clear.cgColor
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        likeButton.addTarget(self, action: #selector(categoryClicked), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(categoryCommentClicked), for: .touchUpInside)
        contentView.backgroundColor = .systemBackground
        adjustUITextViewHeight(arg: mainPostTextView)
        //        MakeMainPost(view: contentView, cellNum: 0)
        contentView.addSubview(userImage)
        userImage.layer.cornerRadius = 18
        
        contentView.addSubview(useridLabel)
        contentView.addSubview(postLocationLabel)
        contentView.addSubview(postTitleTextView)
        contentView.addSubview(categorybadge)
        contentView.addSubview(categorybadge2)
        contentView.addSubview(mainPostTextView)
        contentView.addSubview(PostImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(linewidth)
        contentView.addSubview(lineheight)
        contentView.addSubview(linewidth2)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(commentCountLabel)
        
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
        categorybadge.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(18)
            $0.top.equalTo(self.postLocationLabel).offset(27)
            $0.left.equalTo(20)
        }
        categorybadge2.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(18)
            $0.top.equalTo(self.postLocationLabel).offset(27)
            $0.left.equalTo(self.categorybadge).offset(50)
        }
        postTitleTextView.snp.makeConstraints {
            //            $0.width.equalTo(320)
            $0.height.equalTo(20)
            $0.top.equalTo(self.postLocationLabel).offset(50)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        mainPostTextView.snp.makeConstraints {
            $0.top.equalTo(110)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-85)
        }
        linewidth.snp.makeConstraints {
            $0.width.equalTo(0.5)
            $0.height.equalTo(32)
            $0.centerX.equalTo(self.contentView).offset(0)
            $0.bottom.equalTo(0)
        }
        linewidth2.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.centerX.equalTo(self.contentView).offset(0)
            $0.bottom.equalTo(-32)
        }
        PostImage.snp.makeConstraints {
            //                    $0.top.equalTo(Pcell.mainPostTextView.snp.bottom).offset(10)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(250)
            $0.bottom.equalTo(-90)
        }
        mainPostTextView.snp.makeConstraints {
            $0.top.equalTo(self.postTitleTextView.snp.bottom).offset(5)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-350)
        }
        
        likeButton.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.width.equalTo(73)
            $0.centerX.equalTo(self.contentView).offset(-self.contentView.frame.width / 3)
            $0.bottom.equalTo(-8)
        }
        commentButton.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.width.equalTo(73)
            $0.centerX.equalTo(self.contentView).offset(self.contentView.frame.width / 3)
            $0.bottom.equalTo(-8)
        }
        lineheight.snp.makeConstraints {
            $0.height.equalTo(1.5)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.centerX.equalTo(self.contentView).offset(0)
            $0.bottom.equalTo(0)
        }
        likeCountLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(18)
            $0.left.equalTo(20)
            $0.bottom.equalTo(-45)
        }
        commentCountLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(18)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-45)
        }
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @objc func categoryClicked() {
        self.likeButton.isSelected.toggle()
        reportButtonAction?()
    }
    @objc func categoryCommentClicked() {
        reportCommentButtonAction?()
    }
}