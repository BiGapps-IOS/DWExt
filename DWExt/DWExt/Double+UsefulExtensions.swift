//
//  Double+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import Foundation

extension Double{
    
    var toString: String{
        return "\(self)"
    }
    
    var clean: String{
        return String(format: "%.2f", self)
    }
    
    var clean2: String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var rounded2f: String{
        return String(format: "%.1f", self)
    }
    

}
