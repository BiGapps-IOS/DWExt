//
//  UIImage+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UIImage{
    
    public func cropImageToSquare() -> UIImage? {
        var imageHeight = self.size.height
        var imageWidth = self.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        let refWidth : CGFloat = CGFloat(self.cgImage!.width)
        let refHeight : CGFloat = CGFloat(self.cgImage!.height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.width, height: size.height)
        if let imageRef = self.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: self.imageOrientation)
        }
        
        return nil
    }
    
    public func resizeImage(newSize: CGFloat) -> UIImage {
        let scale = newSize / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: newSize, height: newHeight), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
