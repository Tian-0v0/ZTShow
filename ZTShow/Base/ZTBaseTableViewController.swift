//
//  ZTBaseTableViewController.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SnapKit

typealias Section = SectionModel<ZTReuseIdentifier?, ZTReuseIdentifier>

let NAME_SPACE = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

func ZTControllerFromString(_ str: String) -> UIViewController? {
    guard let type = NSClassFromString(NAME_SPACE + ".\(str)") as? UIViewController.Type else { return nil }
    return type.init()
}

class ZTBaseTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setting()
        self.appendUI()
        self.layoutUI()
        self.handler()
    }
}

extension ZTBaseTableViewController {
    @objc func appendUI(){}
    @objc func layoutUI(){}
    @objc func setting(){}
    @objc func handler(){}
}

class ZTBaseUIObject: NSObject {
    let disposeBag = DisposeBag()
    let view = UIView()
    
    override init() {
        super.init()
        appendUI()
        layoutUI()
        setting()
        handler()
    }
}

class ZTBaseTableViewCell: UITableViewCell {
    lazy var customTemplate = self.custom
    
    required init?(coder: NSCoder) {super.init(coder: coder)}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if let custom = self.customTemplate {
            self.addSubview(custom.view)
            custom.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            return
        }
        
        self.setting()
        self.appendUI()
        self.layoutUI()
        self.handler()
    }
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension ZTBaseTableViewCell {
    @objc var custom: ZTBaseUIObject? {nil}
    @objc func appendUI(){}
    @objc func layoutUI(){}
    @objc func setting(){}
    @objc func handler(){}
    @objc func setView(_ data: Any?) {}
}

extension ZTBaseUIObject {
    @objc func appendUI(){}
    @objc func layoutUI(){}
    @objc func setting(){}
    @objc func handler(){}
    @objc func setView(_ data: Any?){}
}

protocol ZTReuseIdentifier {
    static var id: String {get}
    var id: String {get}
}
extension ZTReuseIdentifier {
    static var id: String {String(describing: self)}
    var id: String {Self.id}
}


