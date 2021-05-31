//
//  UITextField+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


extension UITextField {
    
    
    public func dwAction(_ disposeBag: DisposeBag, limitChars: Int = 0, isLetters: Bool = false, returnDidTap: (()->())?, binder: BehaviorRelay<String?>){
        
        self.rx.text.orEmpty.scan("") { (prev, new) -> String in
            if new.containsEmoji || (limitChars > 0 && new.count > limitChars) || (isLetters && new.containsNumbers) {
                return prev ?? ""
            }else{
                return new
            }
        }.subscribe(self.rx.text).disposed(by: disposeBag)
        
        self.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext: { _ in
            returnDidTap?()
        }).disposed(by: disposeBag)
        
        self.rx.text.bind(to: binder).disposed(by: disposeBag)
        
    }
    
    public func returnDidTap(_ disposeBag: DisposeBag, subscribe: (()->())?){
        self.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext: { _ in
            subscribe?()
        }).disposed(by: disposeBag)
    }
    
    public func disableEmoji(_ disposeBag: DisposeBag){
        self.rx.text.orEmpty.scan("") { (prev, new) -> String in
            if new.containsEmoji {
                return prev ?? ""
            }else{
                return new
            }
        }.subscribe(self.rx.text).disposed(by: disposeBag)
    }
    
}


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
