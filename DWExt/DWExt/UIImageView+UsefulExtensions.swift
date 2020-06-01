//
//  UIImageView+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit


extension UIImageView {
    
    @IBInspectable public var imageColor:UIColor{
        set{
            self.setImageColor(color: newValue)
        }
        get{
            return self.tintColor
        }
    }
    
    public func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
