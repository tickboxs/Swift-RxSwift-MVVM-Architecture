//
//  SearchBar.swift
//  fujiko
//
//  Created by Charlie Cai on 13/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

@IBDesignable
class SearchBar: UISearchBar {
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let str = NSAttributedString(string: placeholder ?? "",
                                         attributes: [NSAttributedString.Key.foregroundColor:
                                            placeholderColor ?? .black])
            
            if let searchTextField = self.value(forKey: "searchField") as? UISearchTextField {
                searchTextField.attributedPlaceholder = str
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
        
    }
    
    private func makeUI( ) {
        
        //去掉上下黑线
//        self.backgroundImage = UIImage(color: UIColor(Theme.Color.background_light) ?? .red)
        self.backgroundImage = UIImage(color: UIColor.white)
        //设置主题为灰色
//        self.barTintColor = UIColor(Theme.Color.background_light)
        //线框宽度
        self.layer.borderWidth = 1
        //线框颜色
        self.layer.borderColor = UIColor("DEDEDE")?.cgColor
        
        //圆角大小
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        //改变图标
        self.setImage(UIImage(named: "search")?
            .byResize(to: CGSize(width: 30, height: 30)), for: .search, state: .normal)
        
        if let searchTextField = self.value(forKey: "searchField") as? UISearchTextField {
//            searchTextField.backgroundColor = UIColor(Theme.Color.background_light)
            searchTextField.backgroundColor = UIColor.white
            //字体颜色
            searchTextField.font = UIFont(name: "Poppins-Regular", size: 21)
            searchTextField.textColor = .black
        }
    
    }
    
}
