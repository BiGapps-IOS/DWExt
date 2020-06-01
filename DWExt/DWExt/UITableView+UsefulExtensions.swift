//
//  UITableView+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit

extension UITableView{
    public func monkeyButton(){
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isUserInteractionEnabled = true
        }
    }
}
