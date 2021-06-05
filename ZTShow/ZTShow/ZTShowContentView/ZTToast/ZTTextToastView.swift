//
//  ZTTextToastView.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit

class ZTTextToastView: ZTBaseToastView {
    lazy var textLabel: UILabel = {
        let l = UILabel()
        l.textColor = ZTToastPodfile.tintColor
        l.numberOfLines = 0
        l.textAlignment = ZTToastPodfile.textAlignment
        return l
    }()
    
    override func appendUI() {
        self.addSubview(textLabel)
    }
    override func layoutUI() {
        textLabel.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(220)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
        }
    }
    
    convenience init(msg: String) {
        self.init()
        self.textLabel.text = msg
    }
}
