//
//  ZTShowWindowRootViewController.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import RxCocoa
import RxSwift

class ZTShowWindowRootViewController: UIViewController {
    let touchAction = PublishRelay<Void>()
    let tap = UITapGestureRecognizer()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZTShowWindowPodfile.maskColor
        self.view.addGestureRecognizer(tap)
        self.tap.rx.event.map{_ in}.bind(to: self.touchAction).disposed(by: disposeBag)
    }
}
