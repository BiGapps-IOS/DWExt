//
//  UIViewController+UsefulExtensions.swift
//  UsefulExtensions
//
//  Created by Denis Windover on 31/05/2020.
//  Copyright © 2020 BigApps. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension UIViewController{
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func presentNavigateOptions(location:CLLocation, locationName:String){
        let actionSheet = UIAlertController.init(title: "נא בחר/י אפליקציית ניווט", message: "", preferredStyle: .actionSheet)
        
        let latitude:CLLocationDegrees =  location.coordinate.latitude
        let longitude:CLLocationDegrees =  location.coordinate.longitude
        
        let cancelAction = UIAlertAction.init(title: "ביטול", style: .cancel, handler: {(alert: UIAlertAction)-> Void in
            
        })
        actionSheet.addAction(cancelAction)
        
        let mapsAction = UIAlertAction.init(title: "Maps", style: .default, handler: {(alert: UIAlertAction)-> Void in
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = locationName
            mapItem.openInMaps(launchOptions: options)
        })
        actionSheet.addAction(mapsAction)
        
        if UIApplication.shared.canOpenURL(URL(string:"waze://")!){
            let wazeAction = UIAlertAction.init(title: "Waze", style: .default, handler: {(alert: UIAlertAction)-> Void in
                UIApplication.shared.open(URL(string:"waze://?ll=\(latitude),\(longitude)&navigate=yes")!, options: [:], completionHandler: nil)
            })
            actionSheet.addAction(wazeAction)
        }
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!){
            let googleMapsAction = UIAlertAction.init(title: "Google Maps", style: .default, handler: {(alert: UIAlertAction)-> Void in
                UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\(locationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&directionsmode=driving")!, options: [:], completionHandler: nil)
            })
            actionSheet.addAction(googleMapsAction)
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension UITextFieldDelegate where Self: UIViewController{
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let typedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if typedString == " "{
            return false
        }
        guard textField.emojiDisabled() else {return false}
        return true
    }
    
}
