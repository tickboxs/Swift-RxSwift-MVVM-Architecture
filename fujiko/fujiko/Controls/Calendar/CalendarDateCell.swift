//
//  CalendarDateCell.swift
//  inspector
//
//  Created by Charlie Cai on 14/9/19.
//  Copyright © 2019 tickboxs. All rights reserved.
//

import JTAppleCalendar
import UIKit

@IBDesignable
class CalendarDateCell: JTACDayCell {
    
    static let identifier = "CalendarDateCell"
    
    // Properties
    public lazy var dayLabel = UILabel()
    private lazy var selectionView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        makeUI()
    }
    
    private func makeUI() {
        
        contentView.backgroundColor = UIColor(Theme.Color.background_light)
        
        contentView.addSubview(selectionView)
        contentView.addSubview(dayLabel)
        
        selectionView.backgroundColor = UIColor(Theme.Color.background_blue)
        selectionView.isHidden = true
        
        dayLabel.textAlignment = .center
        dayLabel.textColor = .black
        dayLabel.font = UIFont(name: "Poppins-Regular", size: 14)
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)

        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 5
        let minDimension = (
            self.contentView.bounds.width > self.contentView.bounds.height ?
            self.contentView.bounds.height : self.contentView.bounds.width) - padding * 2
        selectionView.layer.masksToBounds = true
        selectionView.layer.cornerRadius = minDimension * 0.5
        selectionView.center = self.contentView.center
        selectionView.bounds = CGRect(x: 0, y: 0, width: minDimension, height: minDimension)
        
    }
    
    public func setSelection(_ isSelected: Bool) {
        if isSelected {
            selectionView.isHidden = false
        } else {
            selectionView.isHidden = true
        }
    }
    
}
