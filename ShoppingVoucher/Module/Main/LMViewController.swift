//
//  LMViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxCocoa
import RxSwift
import NVActivityIndicatorView

class LMViewController: UIViewController, Navigatable {

    var viewModel: ViewModel?
    var navigator: Navigator!
    
    let motionShakeEvent = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
    }
    
    
    func bindViewModel() {}
    
    func setupView() {
        hero.isEnabled = true
        
        motionShakeEvent.subscribe(onNext: { _ in
            let theme = ThemManager.type.toggled()
            ThemManager.switch(theme)
        }).disposed(by: rx.disposeBag)
        
        ThemManager.rx
        .bind({ $0.primaryDark }, to: view.rx.backgroundColor)
        
        .disposed(by: rx.disposeBag)
    }
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<APIError>()
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
}


extension LMViewController {
    var inset: CGFloat {
        return Helpers.Dimensions.inset
    }
}
