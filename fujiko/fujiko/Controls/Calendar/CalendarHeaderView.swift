//
//  JTAppleCalendarHeaderView.swift
//  inspector
//
//  Created by Charlie Cai on 14/9/19.
//  Copyright © 2019 tickboxs. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

@IBDesignable
class CalendarHeaderView: View {
    
    // Properties
    lazy var monthLabel = UILabel()
    lazy var leftIconButton = Button(type: .custom)
    lazy var rightIconButton = Button(type: .custom)
    private lazy var weekdayStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
    }
    
    private func makeUI() {
        
        addSubview(monthLabel)
        addSubview(leftIconButton)
        addSubview(rightIconButton)
        addSubview(weekdayStackView)
        
        monthLabel.text = "JANUARY 2019"
        monthLabel.textColor = UIColor(hexString: "#147BDF")
        monthLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        monthLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
        }

        leftIconButton.setImage(UIImage(named: "left_arrow"), for: .normal)
        leftIconButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(monthLabel.snp.centerY)
            make.left.equalTo(self.snp.left)
        }

        rightIconButton.setImage(UIImage(named: "right_arrow"), for: .normal)
        rightIconButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(monthLabel.snp.centerY)
            make.right.equalTo(self.snp.right)
        }

        weekdayStackView.backgroundColor = .darkGray

        let mondayLabel = UILabel()
        let tuesdayLabel = UILabel()
        let wesnesdayLabel = UILabel()
        let thursdayLabel = UILabel()
        let fridayLabel = UILabel()
        let saturdayLabel = UILabel()
        let sundayLabel = UILabel()

        mondayLabel.text = "M"
        tuesdayLabel.text = "T"
        wesnesdayLabel.text = "W"
        thursdayLabel.text = "T"
        fridayLabel.text = "F"
        saturdayLabel.text = "S"
        sundayLabel.text = "S"
        
        self.stylizeLabels(labels: [mondayLabel,
                                    tuesdayLabel,
                                    wesnesdayLabel,
                                    thursdayLabel,
                                    fridayLabel,
                                    saturdayLabel,
                                    sundayLabel])
        
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .fillEqually
        weekdayStackView.alignment = .fill
        weekdayStackView.spacing = 0
        
        weekdayStackView.addArrangedSubview(mondayLabel)
        weekdayStackView.addArrangedSubview(tuesdayLabel)
        weekdayStackView.addArrangedSubview(wesnesdayLabel)
        weekdayStackView.addArrangedSubview(thursdayLabel)
        weekdayStackView.addArrangedSubview(fridayLabel)
        weekdayStackView.addArrangedSubview(saturdayLabel)
        weekdayStackView.addArrangedSubview(sundayLabel)
        
        weekdayStackView.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(monthLabel.snp.bottom).offset(24)
        }
        
    }
    
    private func stylizeLabels(labels: [UILabel]) {
        for label in labels {
            label.textAlignment = .center
            label.textColor = UIColor(hexString: "#CDCDCD")
            label.font = UIFont(name: "Poppins-Regular", size: 14)
        }
    }

}

extension Reactive where Base: CalendarHeaderView {
    
    internal var title: Binder<String> {
        return Binder(self.base) { view, text in
            view.monthLabel.text = text
        }
    }
    
    internal var previousTapped: ControlEvent<Void> {
        return self.base.leftIconButton.rx.tap
    }
    
    internal var nextTapped: ControlEvent<Void> {
        return self.base.rightIconButton.rx.tap
    }
}
