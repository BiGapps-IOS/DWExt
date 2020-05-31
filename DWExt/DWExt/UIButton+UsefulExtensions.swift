//
//  UIButton+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UIButton{
    
    @IBInspectable var isAdjustFontToSizeWidth: Bool{
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
    }
    
    @IBInspectable var imageColor:UIColor{
        set{
            self.setImageColor(color: newValue)
        }
        get{
            return self.tintColor
        }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.imageView?.image = templateImage
        self.imageView?.tintColor = color
    }
    
    func monkeyButton(){
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isUserInteractionEnabled = true
        }
    }
    
}
