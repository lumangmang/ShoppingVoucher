//
//  UIView+Ex.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import SnapKit


extension UIView {
    
    var inset: CGFloat {
        return Helpers.Dimensions.inset
    }
    
    open func setPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        self.setContentHuggingPriority(priority, for: axis)
        self.setContentCompressionResistancePriority(priority, for: axis)
    }
}


public class View: UIView {
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.layer.masksToBounds = true
        updateView()
    }
    
    func updateView() {
        setNeedsDisplay()
    }
}
