//
//  VerificationBoxView.swift
//  fujiko
//
//  Created by Charlie Cai on 14/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import CRBoxInputView
import RxSwift
import RxCocoa

@IBDesignable
class VerificationBoxView: CRBoxInputView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Must Call this method to let CRBoxInputView to do initialization
        super.initDefaultValue()
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Must Call this method to let CRBoxInputView to do initialization
        super.initDefaultValue()
        
        makeUI()
    }
    
    private func makeUI() {
        
        codeLength = 6
        loadAndPrepare(withBeginEdit: true)
        
    }
    
    public func setTextDidChangeBlock(block:@escaping TextDidChangeblock) {
        self.textDidChangeblock = block
    }

}

extension Reactive where Base: VerificationBoxView {
    
    /// input  Driver
    internal var input: Observable<(String, Bool)> {
        
        return Observable.create { (observer) -> Disposable in
            self.base.setTextDidChangeBlock { (text, isFinished) in
                observer.onNext((text ?? "", isFinished))
            }
            return Disposables.create()
        }

    }
}
