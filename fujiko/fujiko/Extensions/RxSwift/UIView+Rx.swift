//
//  StatisticsItemView+Rx.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa
import YYKit

extension Reactive where Base: UIView {
    
    /// Tap Driver
    internal var tapGesture: Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            let tapGesture = UITapGestureRecognizer { _ in
                observer.onNext(())
            }
            self.base.addGestureRecognizer(tapGesture)
            return Disposables.create()
        }
    }
}

#endif
