//
//  UIView+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit


extension UIView {

    /** This is the function to get subViews of a view of a particular type
*/
    public func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }


/** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
        public func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
            var all = [T]()
            func getSubview(view: UIView) {
                if let aView = view as? T{
                all.append(aView)
                }
                guard view.subviews.count>0 else { return }
                view.subviews.forEach{ getSubview(view: $0) }
            }
            getSubview(view: self)
            return all
        }
    }

class HitTracableView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
}


extension UIView{
    
    //MARK: - INSPECTABLE
    @IBInspectable public var isCircle:Bool {
        set {
            if newValue == true{
                layer.cornerRadius = self.bounds.size.width/2.0
                self.clipsToBounds = true
            }
            
        }
        get {
            if self.cornerRadius == self.bounds.size.width/2.0{
                return true
            }
            return false
        }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable public var topCornerRadius:CGFloat {
        set {
            self.setTopRadius(radius: newValue)
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable public var bottomCornerRadius:CGFloat {
        set {
            self.setBottomRadius(radius: newValue)
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable public var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable public var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable public var firstGradientColor:UIColor?{
        set {
            if let color = newValue{
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = self.bounds
                gradientLayer.colors = [color.cgColor]
                self.layer.addSublayer(gradientLayer)
            }
        }
        get {
            if let color = self.firstGradientColor {
                return color
            }
            return nil
        }
    }
    @IBInspectable public var secondGradientColor:UIColor?{
        set {
            if let color = newValue, let sublayers = self.layer.sublayers{
                for layer in sublayers{
                    if layer.isKind(of: CAGradientLayer.self){
                        (layer as! CAGradientLayer).colors?.append(color.cgColor)
                    }
                }
            }
        }
        get {
            if let color = self.secondGradientColor{
                return color
            }
            return nil
        }
    }
    @IBInspectable public var horizontalGradient:Bool{
        set{
            if newValue == true, let sublayers = self.layer.sublayers{
                for layer in sublayers{
                    if layer.isKind(of: CAGradientLayer.self){
                        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.0, y: 0.5)
                        (layer as! CAGradientLayer).endPoint = CGPoint(x: 1.0, y: 0.5)
                    }
                }
            }
        }
        get{
            return self.horizontalGradient
        }
    }
    
    //MARK: - CLASS METHODS
    public func setCornerCircle(corner:UIRectCorner, radius: CGFloat = 20){
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[corner],
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        setBezierBorder(path: path)
        
    }
    
    public func setTopRadius(radius: CGFloat = 20){
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.topLeft, .topRight],
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        setBezierBorder(path: path)
        
    }
    public func setBottomRadius(radius: CGFloat = 20){
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        setBezierBorder(path: path)
        
    }
    
    public func setSideCircle(isRightSide:Bool, radius: CGFloat){
        let topCorner:UIRectCorner = isRightSide ? .topRight : .topLeft
        let bottomCorner:UIRectCorner = isRightSide ? .bottomRight : .bottomLeft
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[topCorner,  bottomCorner],
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        setBezierBorder(path: path)
        
    }
    
    public func setBezierBorder(path: UIBezierPath){
        path.lineWidth = 5
        
        UIColor.white.setStroke()
        UIColor.white.setFill()
        
        path.stroke()
        path.fill()
        
    }
    
    
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public func dropShadow(onlyBottom:Bool = false, color:UIColor = UIColor.lightGray, raduis: CGFloat = 5, opacity: Float = 1){
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = onlyBottom ? CGSize(width: 0, height: 3) : CGSize.zero
        layer.shadowRadius = raduis
    }


    
    public func constraint(withIdentifier:String) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier }.first
    }
    
    public func shakeView() {
        let shake = CABasicAnimation(keyPath: "position")
        let xDelta = CGFloat(5)
        shake.duration = 0.03
        shake.repeatCount = 7
        shake.autoreverses = true
        
        let from_point = CGPoint(x: self.center.x - xDelta, y: self.center.y)
        //let from_point = CGPointMake(shakeView.center.x - xDelta, shakeView.center.y)
        let from_value = NSValue(cgPoint: from_point)
        //let from_value = NSValue(CGPoint: from_point)
        
        let to_point = CGPoint(x: self.center.x + xDelta, y: self.center.y)
        let to_value = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(shake, forKey: "position")
    }
    
}
