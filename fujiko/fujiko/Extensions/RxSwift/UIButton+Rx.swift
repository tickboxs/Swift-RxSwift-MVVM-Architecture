//
//  UIButton+Rx.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    
    /// Bindable sink for `titleColor` property.
    public var titleColor: Binder<UIColor> {
        return Binder(self.base) { button, textColor in
            button.setTitleColor(textColor, for: .normal)
        }
    }
}

#endif
