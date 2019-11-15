//
//  LMTableViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import RxCocoa
import KafkaRefresh
import Toast_Swift

class LMTableViewController: LMViewController, UIScrollViewDelegate {

    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    
    var clearsSelectionOnViewWillAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupView() {
        super.setupView()
        
       tableView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
           self?.headerRefreshTrigger.onNext(())
       })
        
        tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        })
        
        isHeaderLoading.bind(to: tableView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        isFooterLoading.bind(to: tableView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        
        tableView.footRefreshControl.autoRefreshOnFoot = true
        
        error.subscribe(onNext: { [weak self] error in
            switch error {
            case .serverError(response: let response):
                print(response)
            }
            self?.tableView.makeToast("网络错误", title: "请求失败")
        }).disposed(by: rx.disposeBag)
    }
    
    lazy var tableView: TableView = {
        let tableView = TableView(frame: CGRect(), style: .plain)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        return tableView
    }()
}


class TableView: UITableView {
    init() {
        super.init(frame: CGRect(), style: .plain)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    func setupView() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        tableHeaderView = View(height: 1)
        tableFooterView = UIView()
    }
}

extension LMTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.font = UIFont(name: ".SFUIText-Bold", size: 15.0)!
            ThemManager.rx
                .bind({ $0.text }, to: view.textLabel!.rx.textColor)
                .bind({ $0.primaryDark }, to: view.contentView.rx.backgroundColor)
                .disposed(by: rx.disposeBag)
        }
    }
}
