//
//  UIButton+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit


extension UIButton {
    
    @IBInspectable public var numOfLines: Int{
        set {
            self.titleLabel?.numberOfLines = newValue
            self.titleLabel?.textAlignment = .center
            self.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        get {
            self.titleLabel?.numberOfLines ?? 0
        }
    }
    
}


extension UIButton{
    
    @IBInspectable public var isAdjustFontToSizeWidth: Bool{
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
    }
    
    @IBInspectable public var imageColor:UIColor{
        set{
            self.setImageColor(color: newValue)
        }
        get{
            return self.tintColor
        }
    }
    
    public func setImageColor(color: UIColor) {
        let templateImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.imageView?.image = templateImage
        self.imageView?.tintColor = color
    }
    
    public func monkeyButton(){
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isUserInteractionEnabled = true
        }
    }
    
}
