//
//  DTIAlertCenter.swift
//  tapkuclone
//
//  Created by dtissera on 22/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit

private let _defaultCenter = DTIToastCenter()

@objc
public class DTIToastCenter: NSObject {
    /** DTIToast inner class */
    class DTIToast {
        var message: String?
        var image: UIImage?
        
        init (message: String!) {
            self.message = message
        }
        
        init (image: UIImage!) {
            self.image = image
        }
        
        init (message: String!, image: UIImage!) {
            self.message = message
            self.image = image
        }
    }
    
    /** private members */
    private var toasts = [DTIToast]()
    private var active = false
    var toastView = DTIToastView()
    private var registered = false
    var keyboardFrame: CGRect = CGRect.zero

    /** consts */
    private let toastDefaultDelay = TimeInterval(1.4)
    private var toastCurrentDelay:TimeInterval!
    private var toastCustomDelay:TimeInterval!
    
    /** overrides */
    override init () {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationWillChange(notification:)), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /** private methods */
    func showToasts() {
        if (!registered) {
            fatalError("DTIToastCenter ~ you need to call register method in your AppDelegate:didFinishLaunchingWithOptions method !")
        }

        if (self.toasts.count == 0) {
            self.active = false
            return
        }
        self.active = true
        
        // Reset toastView
        self.toastView.alpha = 0
        self.toastView.transform = CGAffineTransform.identity
        
        // Extract top al top
        let toast = self.toasts[0]

        // init toastView
        var windowFrame = self.availableScreenFrame(orientation: nil)
        if (self.iosVersionLessThan8()) {
            windowFrame = windowFrame.swipFromOrientation(orientation: self.currentOrientation())
        }
        
        self.toastView.message = toast.message
        self.toastView.image = toast.image
        self.toastView.adjustSize(maxFrame: windowFrame)

        self.toasts.remove(at: 0)
        UIApplication.shared.keyWindow!.addSubview(self.toastView)

        var transform: CGAffineTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        if (self.iosVersionLessThan8()) {
            transform = self.rotationFromOrientation().concatenating(transform)
        }
        self.toastView.transform = transform
        self.toastView.center = self.availableScreenFrame(orientation: nil).centerIntegral()

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.toastView.alpha = 1;
            var transform: CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            if (self.iosVersionLessThan8()) {
                transform = self.rotationFromOrientation().concatenating(transform)
            }
            self.toastView.transform = transform
        }) { (Bool) -> Void in
            var delay: TimeInterval = self.toastCurrentDelay
            if (toast.message != nil) {
                let words = toast.message!.components(separatedBy:NSCharacterSet.whitespacesAndNewlines)
                // avg person reads 200 words per minute - max 3s
                delay = TimeInterval(min(max(self.toastCurrentDelay, Double(words.count)*60.0/200.0), 5.0))
            }

            UIView.animate(withDuration: 0.3, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
                if (self.iosVersionLessThan8()) {
                    self.toastView.transform = self.rotationFromOrientation()
                }
                self.toastView.alpha = 0;
            }, completion: { (Bool) -> Void in
                self.toastView.removeFromSuperview()
                self.showToasts()
            })
        }
    }

    private func make(message: String?, image: UIImage?) {
        let t = DTIToast(message: message, image: image)
        
        toasts.append(t)
        if (!self.active) {
            self.showToasts()
        }
    }


    /** public methods */
    public class var defaultCenter: DTIToastCenter {
        return _defaultCenter
    }
    
    public func registerCenter() {
        // force register toast center to oberserve keyboard
        self.registered = true
    }

    public func makeText(text: String?, image: UIImage?) {
        self.toastCurrentDelay = toastDefaultDelay
        make(message: text, image: image)
    }

    public func makeText(text: String) {
        self.toastCurrentDelay = toastDefaultDelay
        make(message: text, image: nil)
    }

    public func makeImage(image: UIImage) {
        self.toastCurrentDelay = toastDefaultDelay
        make(message: nil, image: image)
    }
    public func makeText(text: String, timeInterval:TimeInterval) {
        self.toastCurrentDelay = timeInterval
        make(message: text, image: nil)
    }

}

/**
  * System events // notifications
  */
extension DTIToastCenter {
    @objc func keyboardWillAppear(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary;
        let value: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        self.keyboardFrame = value.cgRectValue
        
        var windowFrame = self.availableScreenFrame(orientation: nil)
        if (self.iosVersionLessThan8()) {
            windowFrame = windowFrame.swipFromOrientation(orientation: self.currentOrientation())
        }
        
        let center = self.availableScreenFrame(orientation: nil).centerIntegral()

        UIView.beginAnimations(nil, context: nil)
        self.toastView.adjustSize(maxFrame: windowFrame)
        self.toastView.center = center
        UIView.commitAnimations()
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification) {
        self.keyboardFrame = CGRect.zero
        
        var windowFrame = self.availableScreenFrame(orientation: nil)
        if (self.iosVersionLessThan8()) {
            windowFrame = windowFrame.swipFromOrientation(orientation: self.currentOrientation())
        }

        let center = self.availableScreenFrame(orientation: nil).centerIntegral()

        UIView.beginAnimations(nil, context: nil)
        self.toastView.adjustSize(maxFrame: windowFrame)
        self.toastView.center = center
        UIView.commitAnimations()
    }
    
    @objc func orientationWillChange(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary;
        let value: NSNumber = userInfo[UIApplication.statusBarOrientationUserInfoKey] as! NSNumber
        
        let orientation: UIInterfaceOrientation = UIInterfaceOrientation(rawValue: Int(value.intValue))!

        var toastFrame = self.availableScreenFrame(orientation: orientation)
        var center = toastFrame.centerIntegral() // .swipFromOrientation(orientation)
        if (self.iosVersionLessThan8()) {
            if orientation == UIInterfaceOrientation.portrait {
                toastFrame = toastFrame.swip()
            }
            center = UIScreen.main.bounds.centerIntegral()
        }

        self.toastView.adjustSize(maxFrame: toastFrame)

        UIView.beginAnimations(nil, context: nil)
        self.toastView.transform = CGAffineTransform.identity
        if (self.iosVersionLessThan8()) {
            self.toastView.transform =  self.rotationFromOrientation()//self.rotationFromOrientation(orientation)
        }
        self.toastView.center = center
        UIView.commitAnimations()
    }
}

/**
 * Utilities extension
 */
extension DTIToastCenter {
    /**
    * ios version < ios8
    */
    func iosVersionLessThan8() -> Bool {
        let os_version: String = UIDevice.current.systemVersion;
        return os_version.doubleValue() < 8.0
    }

    /**
      * current orientation of device
      */
    func currentOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    /**
      * calculate available frame depending of keyboard visibility
      */
    func availableScreenFrame(orientation: UIInterfaceOrientation?) -> CGRect {
        var res:CGRect = self.keyboardFrame == CGRect.zero ? UIScreen.main.bounds : self.subtractKeyBoardFrameToWindowFrame(windowFrame: UIScreen.main.bounds, keyboardFrame: self.keyboardFrame)
        if (orientation != nil) {
            // we are in rotating event - keyboard is always hidden
            res = UIScreen.main.bounds.swip()
        }
        return res
    }

    /**
      * return an affine transformation depending of orientation
      */
    private func rotationFromOrientation(orientation: UIInterfaceOrientation) -> CGAffineTransform {
        var angle: CGFloat = 0.0;

        if (orientation == UIInterfaceOrientation.landscapeLeft ) {
            angle = CGFloat(-Double.pi/2)
        }
        else if (orientation == UIInterfaceOrientation.landscapeRight ) {
            angle = CGFloat(Double.pi/2)
        }
        else if (orientation == UIInterfaceOrientation.portraitUpsideDown) {
            angle = CGFloat(Double.pi)
        }
        return CGAffineTransform(rotationAngle: angle)
    }

    /**
      * return an affine transformation depending of orientation
      */
    func rotationFromOrientation() -> CGAffineTransform {
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation

        return self.rotationFromOrientation(orientation: orientation)
    }

    private func subtractKeyBoardFrameToWindowFrame(windowFrame: CGRect, keyboardFrame: CGRect) -> CGRect {
        var kf = keyboardFrame
        if (!CGPoint.zero.equalTo(kf.origin)) {
            if (kf.origin.x > 0) {
                kf.size.width = kf.origin.x
            }
            if (kf.origin.y > 0) {
                kf.size.height = kf.origin.y
            }
            kf.origin = CGPoint.zero;
        }
        else {
            kf.origin.x = abs(kf.size.width - windowFrame.size.width);
            kf.origin.y = abs(kf.size.height - windowFrame.size.height);
            
            
            if (kf.origin.x > 0){
                let temp: CGFloat = kf.origin.x;
                kf.origin.x = kf.size.width;
                kf.size.width = temp;
            }
            else if (kf.origin.y > 0){
                let temp: CGFloat = kf.origin.y;
                kf.origin.y = kf.size.height;
                kf.size.height = temp;
            }
        }
        return windowFrame.intersection(kf);
    }
    

}

