//
//  UITextField+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable public var placeholderColor:UIColor {
        set {
            if let placeholder = self.placeholder{
                self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSAttributedString.Key.foregroundColor: newValue])
            }
        }
        get {
            return self.placeholderColor
        }
    }
    
    public func emojiDisabled()->Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || (self.textInputMode?.primaryLanguage == nil){
            return false
        }
        
        return true
    }
    
    public func emojiAndSpaceDisabled(string:String)->Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || (self.textInputMode?.primaryLanguage == nil){
            return false;
        }
        if self.text == "" && string == " "{
            return false
        }
        
        return true
    }
    
    override open func target(forAction action: Selector, withSender sender: Any?) -> Any? {
        return nil
    }
    
}
