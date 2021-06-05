//
//  ZTLoadingToastView.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit

class ZTLoadingToastView: ZTBaseToastView {
    let contentView = UIView()
    lazy var loadingView: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView()
        load.style = .large
        load.color = ZTToastPodfile.tintColor
        load.startAnimating()
        return load
    }()
    lazy var textLabel: UILabel = {
        let l = UILabel()
        l.textColor = ZTToastPodfile.tintColor
        return l
    }()
    
    override func appendUI() {
        self.addSubview(contentView)
        contentView.addSubview(loadingView)
        contentView.addSubview(textLabel)
    }
    override func layoutUI() {
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.height.greaterThanOrEqualTo(51)
            make.width.greaterThanOrEqualTo(51)
            make.width.lessThanOrEqualTo(120)
        }
        loadingView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(51)
            make.width.equalTo(51)
        }
    }
    
    convenience init(msg: String?) {
        self.init()
        if let msg = msg {
            self.textLabel.text = msg
            
            textLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(loadingView.snp.bottom).offset(5)
                make.bottom.equalToSuperview()
            }
        }else {
            loadingView.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
            }
        }
    }
}
