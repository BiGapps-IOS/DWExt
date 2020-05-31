//
//  UILabel+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UILabel{
    
    @IBInspectable var isAdjustFontToSizeWidth: Bool{
        set {
            self.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.adjustsFontSizeToFitWidth
        }
    }
    
}
