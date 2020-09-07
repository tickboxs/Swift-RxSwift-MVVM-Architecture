//
//  MainNavigationController.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit

final class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    private func makeUI() {
        
        // iOS 13 present full screen
        modalPresentationStyle = .fullScreen
        
        let titleColor: UIColor = .black
        let titleFont = R.font.poppinsRegular(size: 18)!
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(Theme.Color.background_light)
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: titleColor,
             NSAttributedString.Key.font: titleFont]
        
        // 去掉navigationbar下面的横线
        navigationBar.setBackgroundImage(UIImage(color: .clear), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
    }
    
}
