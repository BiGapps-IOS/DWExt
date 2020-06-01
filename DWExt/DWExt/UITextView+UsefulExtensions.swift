//
//  UITextView+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UITextView{
    public func emojiDisabled()->Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || (self.textInputMode?.primaryLanguage == nil){
            return false
        }
        
        return true
    }
    
    public func emojiAndSpaceDisabled(string:String)->Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || (self.textInputMode?.primaryLanguage == nil){
            return true;
        }
        if self.text == "" && string == " "{
            return true
        }
        
        return false
    }
    
    override open func target(forAction action: Selector, withSender sender: Any?) -> Any? {
        return nil
    }
}
