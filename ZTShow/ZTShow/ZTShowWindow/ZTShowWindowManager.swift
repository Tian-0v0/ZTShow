//
//  ZTShowWindowManager.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import RxCocoa
import RxSwift

public class ZTShowWindowManager {
    private static let share = ZTShowWindowManager()
    private let show_queue = DispatchQueue(label: "zt_show_window_queue")
    private let lock = NSLock()
    private var disposeBag = DisposeBag()
    
    private lazy var window: ZTShowWindow = {
        let rect = CGRect(x: 0, y: 0, width: ZTShow.SCREEN_WIDTH, height: ZTShow.SCREEN_HEIGHT)
        let window = ZTShowWindow(frame: rect)
        let root = window.rootViewController as! ZTShowWindowRootViewController
        if ZTShowWindowPodfile.touchHidden {
            root.touchAction.bind(to: self.touchBinder).disposed(by: disposeBag)
        }
        return window
    }()
    
    private var touchAction: PublishRelay<Void> {self.root.touchAction}
    private var root: ZTShowWindowRootViewController {self.window.rootViewController as! ZTShowWindowRootViewController}
    private var view: UIView {self.root.view}
    private var showView: UIView?
    
    private var touchBinder: Binder<Void> {
        return Binder(self) { (ws, _) in
            ZTShowWindowManager.hiddenWindow()
        }
    }
    
    private static func showWindow() {
        self.share.view.backgroundColor = UIColor.clear
        self.share.window.isHidden = false
        UIView.animate(withDuration: 0.1) {
            self.share.view.backgroundColor = ZTShowWindowPodfile.maskColor
        }
    }
    private static func hiddenWindow() {
        UIView.animate(withDuration: 0.1) {
            self.share.view.backgroundColor = UIColor.clear
        } completion: { _ in
            self.share.window.isHidden = true
            self.share.view.subviews.forEach{$0.removeFromSuperview()}
            if !self.share.lock.try() {self.share.lock.unlock()}
        }
    }
    
    private static func show(view: UIView, align: ZTShowAlignment = .center, showTime: DispatchWallTime = .distantFuture) {
        self.share.showView = view
        self.share.show_queue.async {
            self.share.lock.lock()
            DispatchQueue.main.async {
                self.share.view.addSubview(view)
                view.snp.makeConstraints { (make) in
                    switch align {
                    case .bottom:
                        make.bottom.equalTo(-BOTTOM_SAFE_HEIGHT-5)
                    case .center:
                        make.centerY.equalToSuperview()
                    case .top:
                        make.top.equalTo(STATUS_BAR_HEIGHT+5)
                    }
                    make.centerX.equalToSuperview()
                }
                showWindow()
            }
        }
        
        if showTime == .distantFuture {return}
        DispatchQueue.main.asyncAfter(wallDeadline: showTime) {
            if self.share.showView == view {
                hiddenWindow()
            }
        }
    }
}

public extension ZTShowWindowManager {
    static func show(msg: String, align: ZTShowAlignment = .bottom) {
        ZTShowWindowManager.show(view: ZTTextToastView(msg: msg), align: align, showTime: .now()+ZTToastPodfile.messageTime)
    }
    static func load(msg: String? = nil) {
        ZTShowWindowManager.show(view: ZTLoadingToastView(msg: msg))
    }
    static func hidden() {
        ZTShowWindowManager.hiddenWindow()
    }
}
