//
//  TableView+Rx.swift
//  fujiko
//
//  Created by Charlie Cai on 15/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa
import YYKit

extension Reactive where Base: TableView {
    
    /// Refreshing Binder
    internal var isRefreshing: Binder<Bool> {
        return Binder(self.base) { tableView, isRefreshing in
            isRefreshing ? tableView.beginRefreshing() : tableView.endRefreshing()
        }
    }
}

#endif
