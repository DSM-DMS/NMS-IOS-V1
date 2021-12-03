//
//  LikePostCollectionViewCell.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/22.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class LikePostCollectionViewCell: UICollectionViewCell {
    
    let cornerView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.borderWidth = 1
    }
    let postImageView = UIImageView().then {
        $0.image = UIImage(named: "noImage")
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.contentMode = .scaleAspectFill
    }
    let locationLabel = UILabel().then {
        $0.text = "2021년 10월 19일(월) 12:20"
        $0.textColor = .secondaryLabel
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 9)
        $0.textAlignment = .right
    }
    let titleLabel = UILabel().then {
        $0.text = "제목이 들어가요"
        $0.numberOfLines = 2
        $0.textAlignment = .natural
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 9)
    }
    let userLabel = UILabel().then {
        $0.text = "장성헤 (마이스터부)"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 8)
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(cornerView)
        cornerView.addSubview(postImageView)
        cornerView.addSubview(titleLabel)
        cornerView.addSubview(userLabel)
        contentView.addSubview(locationLabel)
        
        cornerView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.bottom.equalTo(-20)
        }
        postImageView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.bottom.equalTo(-50)
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(-15)
        }
        userLabel.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(-5)
        }
        locationLabel.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.leading.equalTo(5)
            $0.trailing.equalTo(-5)
            $0.bottom.equalTo(-2)
        }
    }
}
