//
//  Array+UsefulExtensions.swift
//  DWExt
//
//  Created by Denis Windover on 31/05/2021.
//  Copyright © 2021 BigApps. All rights reserved.
//

import Foundation

extension Array {
    
    public func index(_ index: Int) -> Element? {
        return self.count > index ? self[index] : nil
    }
    
}
