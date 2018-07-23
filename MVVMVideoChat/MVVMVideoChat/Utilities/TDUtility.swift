//
//  TDUtility.swift
//  TourDe
//
//  Created by Tran Manh Quy on 3/29/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import SystemConfiguration

let APP_LINK: String = "https://itunes.apple.com/app/id365876050?mt=8" // temporary
let GOOGLEMAP_URLSHEME: String = "comgooglemaps://"
let GOOGLEMAP_ADDRESS_TO_COORDINATE_APP: String = "comgooglemaps://?saddr=%f,%f&daddr=%f,%f"
let GOOGLEMAP_ADDRESS_TO_COORDINATE_WEB: String = "http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f"
let GOOGLEMAP_NEARBY_CENTER_APP: String = "comgooglemaps://?q=%s&center=%f,%f"
let GOOGLEMAP_NEARBY_CENTER_WEB: String = "http://maps.google.com/maps?q=%s&center=%f,%f"
let GOOGLEMAP_SHOW_POINT_APP: String = "comgooglemaps://?q=%f,%f"
let GOOGLEMAP_SHOW_POINT_WEB: String = "http://maps.google.com/maps?q=%f,%f"

class TDUtility: NSObject {
	
	static let dateFormatter = DateFormatter()
    
    class func showAlertController(_ onView: UIViewController, message: String){

        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: message, preferredStyle: .alert)
        let actionControll = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        alertController.addAction(actionControll)
        onView.present(alertController, animated: true, completion: nil)
    }
	
    class func showAlertController(numOfLine: Int = 1, message: String, completion: (() -> Void)?) {
        let vc: TDOkDialog = TDOkDialog(nibName: TDOkDialog.typeName, bundle: Bundle.main)
        vc.onClickOK = {
            completion?()
        }
        vc.showDialog(completion: nil)

        vc.setText(message)
        switch numOfLine {
        case 1:
            vc.setHeight(140)
        case 2:
            vc.setHeight(160)
        case 3:
            vc.setHeight(180)
        default:
            break
        }
    }
	
    class func showConfirmController(numOfLine: Int = 1, buttonName: String ,message: String, completion: ((Bool) -> Void)?) {
        let vc: TDYesNoDialog = TDYesNoDialog(nibName: TDYesNoDialog.typeName, bundle: Bundle.main)
        
        vc.onClickNo = {
            completion?(false)
        }
        vc.onClickYes = {
            completion?(true)
        }
        vc.showDialog(completion: nil)
        vc.setText(message)
        switch numOfLine {
        case 1:
            vc.setHeight(140)
        case 2:
            vc.setHeight(160)
        case 3:
            vc.setHeight(180)
        default:
            break
        }
        vc.buttonNo.titleLabel?.text = buttonName
	}
    
    class func showOkDialog(numOfLine: Int = 1, message: String, completion:((Bool) -> Void)?) {
        let vc: TDOkDialog = TDOkDialog(nibName: TDOkDialog.typeName, bundle: Bundle.main)
        vc.onClickOK = {
            completion?(true)
        }
        vc.showDialog(completion: nil)
        vc.setText(message)
        switch numOfLine {
        case 1:
            vc.setHeight(140)
        case 2:
            vc.setHeight(160)
        case 3:
            vc.setHeight(180)
        default:
            break
        }
    }
    
    class func showProgressHud (){
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    class func dismissHud() {
        SVProgressHUD.dismiss()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "FINISH_API_LOADING"), object: nil)
    }
    
    class func isValidEmail(emailString:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
    class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func showErrorMessage(_ onView:UIViewController, errStatusCode:Int) {

        let keyString = (NSNumber(value: errStatusCode)).stringValue;
        let errmess = NSLocalizedString(keyString, tableName: "ErrorMessage", bundle: Bundle.main , value: "", comment: "")

        showAlertController(onView, message: errmess)
    }
    
    class func getArraySplitString(_ param:String) -> [String]{
        if  !param.isEmpty {
            return param.components(separatedBy: "|")
        }
        return []
    }
    
    class func sizeString(_ stringParam:String) -> CGSize {
        
        return (stringParam as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica Bold", size: 17)!])
    }
    
    class func heightForComment(_ strParam:String,font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: strParam).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    class func getYearBirthday(_ stringBirthday:String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateconvert = formater.date(from: stringBirthday)
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: dateconvert!, to: Date())
        return "Age :" + "\(components.year!)"
    }
    
    class func getDate(_ stringDate:String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateconvert = formater.date(from: stringDate)
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: dateconvert!)
    }
    
    class func convert10ToBinary(dec: Int) -> String{
        let binary = String(dec, radix: 2)
        print("Binary : \(binary)")
        return binary
    }
    
    class func fromBinaryToMonthString(_ binaryString: String) -> String {
        var monthString: String = ""
        var month: Int = 1
        for (index, char) in binaryString.characters.enumerated().reversed() {
            print("\(index) - " + String(char))
            if String(char) == "1" {
                monthString += "\(month)" + ","
            }
            month += 1
        }
        if monthString.length > 0 {
            monthString.removeLast()
        }
        monthString += "月"
        return monthString
    }
    
    class func showDirectionOnGoogleMap(sPoint: CLLocationCoordinate2D, dPoint: CLLocationCoordinate2D) {
        let urlString: String = String(format: GOOGLEMAP_ADDRESS_TO_COORDINATE_APP, sPoint.latitude, sPoint.longitude, dPoint.latitude, dPoint.longitude)
        let webUrl: String = String(format: GOOGLEMAP_ADDRESS_TO_COORDINATE_WEB, sPoint.latitude, sPoint.longitude, dPoint.latitude, dPoint.longitude)
        openGoogleMap(urlString, webUrl)
    }
    
    class func showDirectionOnGoogleMapWithArraySpots(arraySpots: [CLLocationCoordinate2D]) {
        var urlString:String?
        var webUrl:String?
        
        if arraySpots.count>1{
            webUrl = "https://www.google.com/maps/dir"
            for i in 0..<arraySpots.count {
                webUrl?.append("/\(arraySpots[i].latitude),\(arraySpots[i].longitude)")
            }
            
            urlString = "comgooglemaps://?saddr=\(arraySpots[0].latitude),\(arraySpots[0].longitude)&daddr=\(arraySpots[1].latitude),\(arraySpots[1].longitude)"
            if arraySpots.count > 2{
                for i in 2..<arraySpots.count {
                    urlString?.append("+to:\(arraySpots[i].latitude),\(arraySpots[i].longitude)")                }
            }
        }
        
        if let app = urlString{
            if let web = webUrl {
                 openGoogleMap(app, web)
            }
        }
    }
    
    class func showNearbyPlaceOnGoogleMap(_ searchKey: String?,_ centerPoint: CLLocation){
        let urlString: String = String(format: GOOGLEMAP_NEARBY_CENTER_APP, centerPoint.coordinate.latitude, centerPoint.coordinate.longitude)
        let webUrl: String = String(format: GOOGLEMAP_NEARBY_CENTER_WEB, centerPoint.coordinate.latitude, centerPoint.coordinate.longitude)
        openGoogleMap(urlString, webUrl)
    }
    
    class func showPointOnGoogleMap(_ point: CLLocation){
        let urlString: String = String(format: GOOGLEMAP_SHOW_POINT_APP, point.coordinate.latitude, point.coordinate.longitude)
        let webUrl: String = String(format: GOOGLEMAP_SHOW_POINT_WEB, point.coordinate.latitude, point.coordinate.longitude)
        openGoogleMap(urlString, webUrl)
    }
    
    class func showPointOnGoogleMap(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees){
        let urlString: String = String(format: GOOGLEMAP_SHOW_POINT_APP, latitude, longitude)
        let webUrl: String = String(format: GOOGLEMAP_SHOW_POINT_WEB, latitude, longitude)
        openGoogleMap(urlString, webUrl)
    }
    
    class func openGoogleMap(_ url: String, _ webUrl: String) {
        if (UIApplication.shared.canOpenURL(URL(string: GOOGLEMAP_URLSHEME)!)) {
            let urlString: String = String(format: url)
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: { (opened) in
                
            })
        } else {
            NSLog("Can't use comgooglemaps:// -> OPEN Safari");
            let urlString: String = String(format: webUrl)
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: { (opened) in
                
            })
        }
    }
    
    class func openNaviTime(){
        let naviTimeApp = URL(string: "navitime://")
        
        let appLink = "https://itunes.apple.com/app/id365876050?mt=8"
        let naviTimeUrl = URL(string: appLink)
        
        if UIApplication.shared.canOpenURL(naviTimeApp!){
            UIApplication.shared.open(naviTimeApp!)
        }else{
            if UIApplication.shared.canOpenURL(naviTimeUrl!){
                UIApplication.shared.open(naviTimeUrl!)
            }
        }
    }
    
    class func openAppStore() {
        let appUrl = URL(string: APP_LINK)
        if UIApplication.shared.canOpenURL(appUrl!) {
            UIApplication.shared.open(appUrl!)
        }
    }
	
	class func distance(between A: CLLocation, B: CLLocation) -> CLLocationDistance{
		return A.distance(from: B)
	}
    
    class func calculateAvarageSpeed(_ hour: Int, _ min: Int, _ sec: Int, _ distance:String) -> String{
        let hourDec = NSDecimalNumber.init(value: hour)
        var minDec = NSDecimalNumber.init(value: min)
        var secDec = NSDecimalNumber.init(value: sec)
        minDec = minDec.dividing(by: "60".toDecimal)
        secDec = secDec.dividing(by: "3600".toDecimal)
        var totalTimeInHour = hourDec.adding(minDec.adding(secDec))
        return (distance.toDecimal.dividing(by: totalTimeInHour).round(digit: 2, mode: .plain).stringValue)  + "km/h"
    
    }
    
    class func displayAverageRate(_ avarageStar: Double) -> String{
        
        if avarageStar < 0.5{
            return "0"
        }else if avarageStar >= 0.5 && avarageStar < 1{
            return "05"
        }else if avarageStar >= 1 && avarageStar < 1.5{
            return "1"
        }else if avarageStar >= 1.5 && avarageStar < 2{
            return "15"
        }else if avarageStar >= 2 &&  avarageStar < 2.5{
            return "2"
        }else if avarageStar >= 2.5 && avarageStar < 3{
            return "25"
        }else if avarageStar >= 3 && avarageStar < 3.5{
            return "3"
        }else if avarageStar >= 3.5 && avarageStar < 4{
            return "35"
        }else if avarageStar >= 4 && avarageStar < 4.5{
            return "4"
        }else if avarageStar >= 4.5 && avarageStar < 5{
            return "45"
        }else{
            return "5"
        }
    }
    
    public class CheckInternet{
        class func internetConnection() -> Bool{
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0,0,0,0,0,0,0,0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress){
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1){zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags:SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!,  &flags) == false{
                return false
            }
            
            //Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            return ret
        }
    }

}


