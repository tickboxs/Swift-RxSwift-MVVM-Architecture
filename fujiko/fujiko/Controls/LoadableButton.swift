//
//  LoadableButton.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LoadableButton: Button, ButtonLoadable {
    
    private var buttonTitle: String?
    private var _activityIndicator: UIActivityIndicatorView?
    var activityIndicator: UIActivityIndicatorView {
        
        get { if _activityIndicator == nil {
                _activityIndicator = createActivityIndicator()
            }
            return _activityIndicator!
        }
        
        set { _activityIndicator = newValue }
    }
    
    func showLoading() {
            
        // Disable Button
        if self.titleLabel?.text != "" { self.buttonTitle = self.titleLabel?.text }
        self.setTitle("", for: .normal)
    
        showSpinning()
    }
    
    func hideLoading() {
        // Enable Button
        if self.buttonTitle == nil { self.buttonTitle = self.titleLabel?.text }
        self.setTitle(buttonTitle, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(xCenterConstraint)
    
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
