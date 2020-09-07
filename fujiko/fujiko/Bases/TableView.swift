//
//  TableView.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class TableView: UITableView {
    
    private lazy var refreshView = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
    }
    
    private func makeUI() {
        
        refreshView.backgroundColor = .clear
        refreshView.tintColor = .purple
        refreshView.tintAdjustmentMode = .dimmed

        addSubview(refreshView)
        refreshView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        endRefreshing()
        
    }
    
    public func beginRefreshing() {
        refreshView.isHidden = false
        refreshView.startAnimating()
    }
    
    public func endRefreshing() {
        refreshView.isHidden = true
        refreshView.stopAnimating()
    }
}
