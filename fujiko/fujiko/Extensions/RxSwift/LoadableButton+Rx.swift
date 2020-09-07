//
//  LoadableButton+Rx.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: LoadableButton {
    
    /// Bindable sink for `titleColor` property.
    internal var loading: Binder<Bool> {
        return Binder(self.base) { button, isLoading in
            if isLoading { button.showLoading() } else { button.hideLoading() }
        }
    }
}

#endif
