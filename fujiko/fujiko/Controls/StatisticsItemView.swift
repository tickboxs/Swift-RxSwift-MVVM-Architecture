//
//  StatisticsItemView.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class StatisticsItemView: UIView {
    
    @IBOutlet weak var percentageLabel: Label!
    @IBOutlet weak var statusLabel: Label!
    
    @IBInspectable var percentage: CGFloat = 45 {
        didSet {
            percentageLabel.text = "\(percentage)%"
        }
    }
    
    @IBInspectable var statusTitle: String = "IN PROCESS" {
        didSet {
            statusLabel.text = statusTitle
            
            var statusLabelBackgroundColor: UIColor = .red
            
            switch statusTitle {
            case "IN PROCESS":
                statusLabelBackgroundColor = .blue
            case "COMPLETED":
                statusLabelBackgroundColor = .black
            case "TO DO":
                statusLabelBackgroundColor = .gray
            case "IN REVIEW":
                statusLabelBackgroundColor = .orange
            default:
                statusLabelBackgroundColor = .blue
            }
            
            statusLabel.backgroundColor = statusLabelBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StatisticsItemView", bundle: bundle)
        
        guard let nibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return
        }
        
        addSubview(nibView)
        
        nibView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        layer.shadowColor = UIColor("BCBCBC")?.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
    }
    
    public func choose(status: Bool) {
        
        if status {
            
            let shadowOpacityanimation = CABasicAnimation(keyPath: "shadowOpacity")
            shadowOpacityanimation.fromValue = 0.4
            shadowOpacityanimation.toValue = 1
            shadowOpacityanimation.duration = 0.25
            shadowOpacityanimation.isRemovedOnCompletion = false
            shadowOpacityanimation.fillMode = .forwards
            layer.add(shadowOpacityanimation, forKey: shadowOpacityanimation.keyPath)
            
            let shadowColoranimation = CABasicAnimation(keyPath: "shadowColor")
            shadowColoranimation.fromValue = UIColor("BCBCBC")?.cgColor
            shadowColoranimation.toValue = UIColor.black.cgColor
            shadowColoranimation.duration = 0.25
            shadowColoranimation.isRemovedOnCompletion = false
            shadowColoranimation.fillMode = .forwards
            layer.add(shadowColoranimation, forKey: shadowColoranimation.keyPath)
        } else {
            
            let shadowOpacityanimation = CABasicAnimation(keyPath: "shadowOpacity")
            shadowOpacityanimation.fromValue = 1
            shadowOpacityanimation.toValue = 0.4
            shadowOpacityanimation.duration = 0.25
            shadowOpacityanimation.isRemovedOnCompletion = false
            shadowOpacityanimation.fillMode = .forwards
            layer.add(shadowOpacityanimation, forKey: shadowOpacityanimation.keyPath)
            
            let shadowColoranimation = CABasicAnimation(keyPath: "shadowColor")
            shadowColoranimation.fromValue = UIColor.black.cgColor
            shadowColoranimation.toValue = UIColor("BCBCBC")?.cgColor
            shadowColoranimation.duration = 0.25
            shadowColoranimation.isRemovedOnCompletion = false
            shadowColoranimation.fillMode = .forwards
            layer.add(shadowColoranimation, forKey: shadowColoranimation.keyPath)
        }
    }
}
