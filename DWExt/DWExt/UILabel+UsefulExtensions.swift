//
//  UILabel+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit


extension UILabel {
    
    @IBInspectable var dwText: String? {
        set { self.text = newValue?.contains("\\n") == true ? newValue?.replacingOccurrences(of: "\\n", with: "\n") : newValue }
        get { return self.text }
    }
    
    
}


extension UILabel{
    
    @IBInspectable public var isAdjustFontToSizeWidth: Bool{
        set {
            self.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.adjustsFontSizeToFitWidth
        }
    }
    
}
