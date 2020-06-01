//
//  String+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension String{
    
    public var toInt:Int{
        return Int(self) ?? 0
    }
    
    public var toDouble: Double? {
        return Double(self)
    }
    
    public var localized:String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public func toast(_ interval: Double? = nil){
        if let interval = interval {
            DTIToastCenter.defaultCenter.makeText(text: self, timeInterval:interval)
        }else{
            DTIToastCenter.defaultCenter.makeText(text: self)
        }
    }
    
    public func isEmailValid() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
        
    }
    
    public func isFullNameValid() -> Bool {
        
        //let fullNameFormat = "[א-תa-zA-Z]{2,15}+[ ][א-תa-zA-Z]{2,15}"
        let fullNameFormat = "([א-תa-zA-Z]{2,}[ ]){1,3}+[א-תa-zA-Z]{2,}"
        let fullNamePredicate = NSPredicate(format:"SELF MATCHES %@", fullNameFormat)
        return fullNamePredicate.evaluate(with: self)
        
    }
    public func isHebrew() -> Bool {
        
        let fullNameFormat = "[א-ת 0-9,]{0,}"
        let fullNamePredicate = NSPredicate(format:"SELF MATCHES %@", fullNameFormat)
        return fullNamePredicate.evaluate(with: self)
        
    }
    public func isHebrew_() -> Bool {
        
        let fullNameFormat = "[\"א-ת 0-9,-]{0,}"
        let fullNamePredicate = NSPredicate(format:"SELF MATCHES %@", fullNameFormat)
        return fullNamePredicate.evaluate(with: self)
        
    }
    
    public func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.date(from: self)!
    }
    
    public func isNameValid() -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[א-תa-zA-Z ]{2,12}$", options: .caseInsensitive)
            if regex.matches(in: self, options: [], range: NSMakeRange(0, self.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    
//    func isPhoneValid() -> String? {
//
//        let phoneUtil = NBPhoneNumberUtil()
//        let regionCode = "IL"
//
//        if let phoneNumber:NBPhoneNumber = try? phoneUtil.parseAndKeepRawInput(self, defaultRegion: regionCode){
//            if phoneUtil.isValidNumber(phoneNumber){
//                let phoneNumberRegionCode = phoneUtil.getRegionCode(forCountryCode: phoneNumber.countryCode)
//                if phoneNumberRegionCode == regionCode && phoneUtil.getNumberType(phoneNumber).rawValue == 1{
//                    // mobile - 1, but in some regions 2 also can be mobile (US)
//                    if let phone:String = try? phoneUtil.format(phoneNumber, numberFormat: .E164){
//                        return phone
//                    }
//                }
//            }
//        }
//
//        return nil
//
//    }
    
    
    public var condensedWhitespace: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    public var toMD5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
}
