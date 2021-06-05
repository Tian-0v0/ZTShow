//
//  ZTShowWindow.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import RxCocoa
import RxSwift

class ZTShowWindow: UIWindow {
    let disposeBag = DisposeBag()
    let root = ZTShowWindowRootViewController()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    required init?(coder: NSCoder) {super.init(coder: coder)}
    
    func setting() {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            self.windowScene = scene as? UIWindowScene
        }
        self.windowLevel = .statusBar + 100
        self.rootViewController = root
        self.isHidden = true
    }
}
