//
//  MainPostCrellFunc.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/22.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa


func adjustUITextViewHeight(arg : UITextView)
{
    arg.sizeToFit()
    arg.isScrollEnabled = false
}

func badgeSetting(title : String, target : UIButton) {
    target.setTitle("\(title)", for: .normal)
    target.backgroundColor = UIColor(named: "MainColor1")
    target.titleLabel?.font = UIFont(name: "TwCenClassMTStd-Regular", size: 8.0)
    target.setTitleColor(UIColor.white, for: .normal)
    target.layer.borderWidth = 0
    target.layer.cornerRadius = 9
}
