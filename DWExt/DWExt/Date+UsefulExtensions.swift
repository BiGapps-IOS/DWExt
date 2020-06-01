//
//  Date+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import Foundation

extension Date{
    
    public var weekDay: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let weekDay = dateFormatter.string(from: self)
            return weekDay
        }
    }
    
    public var weekDayHebrew: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "he_IL")
            dateFormatter.dateFormat = "EEEE"
            let weekDay = dateFormatter.string(from: self)
            return weekDay
        }
    }
    
    public var yearHebrew: String{
        get{
            let hebrew = Calendar(identifier: .hebrew)
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "he_IL")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.calendar = hebrew
            formatter.dateFormat = "yyyy"
            return formatter.string(from: self)
        }
    }
    
    public var monthHebrew: String{
        get{
            let hebrew = Calendar(identifier: .hebrew)
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "he_IL")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.calendar = hebrew
            formatter.dateFormat = "MMM"
            return formatter.string(from: self)
        }
    }
    
    public var dayHebrew: String{
        get{
            let hebrew = Calendar(identifier: .hebrew)
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "he_IL")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.calendar = hebrew
            formatter.dateFormat = "dd"
            return formatter.string(from: self)
        }
    }
    
    public var dateHebrew: String{
        get{
            let hebrew = Calendar(identifier: .hebrew)
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "he_IL")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.calendar = hebrew
            return formatter.string(from: self)
        }
    }
    
    public var time: String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
    }
    
    public var fullDateSlashSep: String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: self)
        }
    }
    
    public var fullDateSpaceSep:String {
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM yyyy"
            return formatter.string(from: self)
        }
    }
    public var fullDateDotSep:String {
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return formatter.string(from: self)
        }
    }
    public var fullDateWithTime:String {
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm dd.MM.yyyy"
            return formatter.string(from: self)
        }
    }
    
    
    /// Returns the amount of years from another date
    public var years:Int {
        return Calendar.current.dateComponents([.year], from: Date(), to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    public var months:Int {
        return Calendar.current.dateComponents([.month], from: Date(), to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    public var weeks:Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: Date(), to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    public var days:Int {
        return Calendar.current.dateComponents([.day], from: Date(), to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    public var hours:Int {
        return Calendar.current.dateComponents([.hour], from: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    public var minutes:Int {
        return Calendar.current.dateComponents([.minute], from: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    public var seconds:Int {
        return Calendar.current.dateComponents([.second], from: Date(), to: self).second ?? 0
    }
}
