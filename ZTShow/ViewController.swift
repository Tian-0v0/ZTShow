//
//  ZTShowExampleViewController.swift
//  Template
//
//  Created by zhangtian on 2021/6/1.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class ViewController: ZTBaseTableViewController {
    let viewModel = ZTShowExampleViewModel()
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    required init?(coder: NSCoder) {super.init(coder: coder)}
    
    override func setting() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.tableView.rowHeight = 80
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(ZTShowExampleTableViewCell.self, forCellReuseIdentifier: ZTShowExampleTableViewCellModel.id)
    }
    override func handler() {
        self.viewModel.data.bind(to: self.tableView.rx.items(dataSource: self.viewModel.datasource)).disposed(by: disposeBag)
        self.tableView.rx.itemSelected.bind {ip in
            if ip.section == 0 {
                if ip.row == 0 {
                    ZTShowWindowManager.show(msg: "提示信息-top", align: .top)
                }
                if ip.row == 1 {
                    ZTShowWindowManager.show(msg: "提示信息-center", align: .center)
                }
                if ip.row == 2 {
                    ZTShowWindowManager.show(msg: "提示信息-bottom", align: .bottom)
                }
            }
            
            if ip.section == 1 {
                if ip.row == 0 {
                    ZTShowWindowManager.load(msg: "提示信息-center")
                }
                if ip.row == 1 {
                    ZTShowWindowManager.load()
                }
            }
        }.disposed(by: disposeBag)
    }
}

class ZTShowExampleViewModel {
    let disposeBag = DisposeBag()
    var data = BehaviorRelay<[Section]>(value: [])
    var datasource: RxTableViewSectionedReloadDataSource<Section>!
    
    init() {
        self.datasource = .init(configureCell: { (ds, tb, ip, item) -> UITableViewCell in
            let cell = tb.dequeueReusableCell(withIdentifier: item.id) as! ZTBaseTableViewCell
            cell.setView(item)
            return cell
        })
        reloadData()
    }
    
    func reloadData() {
        let titles = [["文字提示-top", "文字提示-center", "文字提示-bootm"], ["loading-无文字", "loading-带文字"]]
        
        var data = [Section]()
        for titles in titles {
            var items = [ZTShowExampleTableViewCellModel]()
            for title in titles {
                items.append(.init(title: title))
            }
            data.append(.init(model: nil, items: items))
        }
    
        self.data.accept(data)
    }
}

struct ZTShowExampleTableViewCellModel: ZTReuseIdentifier {
    var title: String
}

class ZTShowExampleTableViewCell: ZTBaseTableViewCell {
    override var custom: ZTBaseUIObject? {
        let l = UILabel()
        return ZTTitleTemplate(l: l)
    }
    
    override func setView(_ data: Any?) {
        guard let data = data as? ZTShowExampleTableViewCellModel,
              let custom = self.customTemplate as? ZTTitleTemplate else { return }
        custom.titleLabel.text = data.title
    }
}

class ZTTitleTemplate: ZTBaseUIObject {
    let titleLabel: UILabel
    
    init(l: UILabel) {
        self.titleLabel = l
        super.init()
    }
    
    override func appendUI() {
        view.addSubview(titleLabel)
    }
    override func layoutUI() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
}


