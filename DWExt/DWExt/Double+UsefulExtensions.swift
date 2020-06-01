//
//  Double+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import Foundation

extension Double{
    
    public var toString: String{
        return "\(self)"
    }
    
    public var rounded2F: String{
        return String(format: "%.2f", self)
    }
    
    public var clean: String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    public var rounded1f: String{
        return String(format: "%.1f", self)
    }
    

}
