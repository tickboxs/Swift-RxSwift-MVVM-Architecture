//
//  TextView.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class TextView: UITextView {
    
    private let disposeBag = DisposeBag()
    
    private let placeholderLabel = Label()
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            self.placeholderLabel.text = placeholder
        }
    }

    @IBInspectable var placeholderColor: UIColor = .black {
        didSet {
            self.placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
        
    }
    
    private func makeUI() {
        
        addSubview(placeholderLabel)

        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        placeholderLabel.font = self.font
        
        self.rx.value
            .orEmpty
            .map { $0 != ""}
            .asDriver(onErrorJustReturn: false)
            .drive(placeholderLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
