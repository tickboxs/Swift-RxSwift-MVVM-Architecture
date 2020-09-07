//
//  SlidingTabBar.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@IBDesignable
class SlidingTabBar: View {
    
    let BottomLine_Height = 2
    
    private lazy var stackView = UIStackView()
    private lazy var bottomLine = View()
    
    @IBInspectable var unselectedColor: UIColor = .lightGray {
        didSet {
            for button in buttons {
                button.setTitleColor(unselectedColor, for: .normal)
            }
        }
    }
    
    @IBInspectable var selectedColor: UIColor = .purple {
        didSet {
            for button in buttons {
                button.setTitleColor(selectedColor, for: .selected)
            }
            bottomLine.backgroundColor = selectedColor
        }
    }
    
    @IBInspectable var titleText: String? {
        didSet {
            if titleText != nil {
                removeAllSubviews()
                buttons.removeAll()
                makeUI(titleText!)
            }
        }
    }
    
    let selectedIndexSubject = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
    private var buttons = [Button]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func makeUI(_ titleText: String) {
        
        addSubview(stackView)
        addSubview(bottomLine)
        
        stackView.backgroundColor = .darkGray
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 0
        
        let titles = titleText.split(separator: ",").compactMap { "\($0)" }
        assert(titles.count >= 1, "title have to be greater than 1")
        
        for (index, title) in titles.enumerated() {
            let button = Button(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(unselectedColor, for: .normal)
            button.setTitleColor(selectedColor, for: .selected)
            buttons.append(button)
            
            button.rx.controlEvent(.touchUpInside)
                .map { index }
                .bind(to: selectedIndexSubject)
                .disposed(by: disposeBag)
            
            stackView.addArrangedSubview(button)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        selectedIndexSubject
            .skip(1)
            .subscribe(onNext: { [unowned self] (index) in
                self.animateTabTranslation(index: index)
            }).disposed(by: disposeBag)
        
        bottomLine.backgroundColor = selectedColor
        
        let button = self.buttons[0]
        button.isSelected = true
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(button.snp.bottom)
            make.left.equalTo(button.snp.left)
            make.right.equalTo(button.snp.right)
            make.height.equalTo(BottomLine_Height)
        }
        
    }
    
    public func animateTabTranslation(index: Int) {
        let button = self.buttons[index]
        self.bottomLine.snp.remakeConstraints { (make) in
            make.top.equalTo(button.snp.bottom)
            make.left.equalTo(button.snp.left)
            make.right.equalTo(button.snp.right)
            make.height.equalTo(BottomLine_Height)
        }
        
        for button in self.buttons {
            button.isSelected = false
        }
        self.buttons[index].isSelected = true
        
        UIView.animate(withDuration: 0.25) {
            
            self.layoutIfNeeded()
        }
    }
}

extension Reactive where Base: SlidingTabBar {
    
    /// Tap Driver
    internal var tap: BehaviorRelay<Int> {
        return self.base.selectedIndexSubject
    }

}
