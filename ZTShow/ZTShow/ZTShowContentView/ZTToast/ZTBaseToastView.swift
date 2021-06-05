//
//  ZTBaseToastView.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import SnapKit

class ZTBaseToastView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
        appendUI()
        layoutUI()
        handler()
    }
    required init?(coder: NSCoder) {super.init(coder: coder)}
    func setting() {
        self.backgroundColor = ZTToastPodfile.backgroundColor
        self.layer.cornerRadius = ZTToastPodfile.cornerRadius
        self.layer.masksToBounds = true
    }
    func appendUI() {}
    func layoutUI() {
        self.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(30).priority(999)
            make.width.greaterThanOrEqualTo(30).priority(999)
        }
    }
    func handler() {}
}
