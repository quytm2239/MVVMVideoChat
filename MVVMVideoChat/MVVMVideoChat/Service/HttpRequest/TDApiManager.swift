//
//  TDApiManager.swift
//  TourDe
//
//  Created by Hoang Huynh Man on 3/29/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class TDApiManager {
    
    static var sharedInstance: TDApiManager = TDApiManager()
    var Host: String = Bundle.main.object(forInfoDictionaryKey: "ApiHost") as! String
	var token: String = UserDefaults.standard.getToken()
    var hasPostHidePlaceHolder: Bool = false
    init() {
        
    }
    
    func createQueryRequest(path: String, params: [String: Any]) -> String {
        var finalQuery = Host + path + "?"
        
        for (key, value) in params {
            if let number = value as? Int {
                finalQuery += key + "=" + "\(number)" + "&"
            } else if let number = value as? Float {
                finalQuery += key + "=" + "\(number)" + "&"
            } else if let number = value as? Double {
                finalQuery += key + "=" + "\(number)" + "&"
            } else if let string = value as? String {
                finalQuery += key + "=" + string + "&"
            }
        }
        finalQuery.removeLast()
        return finalQuery
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToArrayString(text: String) -> [String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func createFormUrlEncoded() -> HTTPHeaders {
        return [
            "Content-Type":"application/x-www-form-urlencoded",
            "token": token
        ]
    }
    
    func createFormMultiPart() -> HTTPHeaders {
        return [
            "Content-Type":"multipart/form-data",
            "token": token
        ]
    }
	
	func getTokenFromNormalResponse(_ params: [String: Any], _ dict: [String:Any]?) {
		if dict != nil {
			if let token = dict![TOKEN] as? String{
				UserDefaults.standard.saveToken(token)
			}
			UserDefaults.standard.saveEmail(params[EMAIL] as! String)
			UserDefaults.standard.savePassword(params[PASSWORD] as! String)
		} else {
			TDUtility.showAlertController(message: "Server sent wrong format response", completion: {})
		}
	}
	
	func getTokenFromSnsResponse(_ params: [String: Any], _ dict: [String:Any]?) {
		if dict != nil {
			if let token = dict![TOKEN] as? String {
				UserDefaults.standard.saveToken(token)
			}
			let snsID = params[TDApiKey.sns_id] as! String
			let snsKind: SnsKind = SnsKind(rawValue: params[TDApiKey.sns_kind] as! Int)!
			UserDefaults.standard.saveSnsID(snsID, snsKind)
		} else {
			TDUtility.showAlertController(message: "Server sent wrong format response", completion: {})
		}
	}
	
    // MARK: - Basic request
    func get(path: String, params: [String: Any], completion: @escaping(Error?,Data?) -> Void) {
        let url = createQueryRequest(path: path, params: params)
        //let url = Host + path
        //print("Link: " + url)
        let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		Alamofire.request(safeUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: createFormUrlEncoded()).response(completionHandler: { response in
			if response.error != nil {
				print(response.error.debugDescription)
				let  controller = VCDelegate.window?.rootViewController
				if controller is UINavigationController {
					TDUtility.showAlertController(message: (response.error?.localizedDescription)!, completion: {})
				} else {
					TDUtility.showAlertController(message: (response.error?.localizedDescription)!, completion: {})
				}
			}
			completion(response.error,response.data)
		})
	}
	
	func post(path: String, params: [String: Any], completion: @escaping (Error?,Data?) -> Void) {
		let url = Host + path
		TDUtility.showProgressHud()
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: createFormUrlEncoded())
            .response { response in
                completion(response.error,response.data)
				TDUtility.dismissHud()
        }
    }
    
    /*
     func uploadPhotos(_ dataImages:[Data],completion:@escaping (_ resulte:[String:Any]) -> Void) {
     
         let url = URL(string: baseUrl! +  URL_UPLOAD_PHOTOS)!
        
         Alamofire.upload(multipartFormData: { (multiPartForm) in
             for item in dataImages {
                multiPartForm.append(item, withName: "file", fileName: "\(Date().timeIntervalSince1970 * 1000).png", mimeType: "image/png")
             }
         }, with: request(url)) { (encodingResult) in
             switch encodingResult {
                 case .success(let upload, _, _):
                     upload.responseJSON { response in
                     print(response.result.value)
                     completion(response.result.value as! [String:Any])
                     }
                     break
                 case .failure(let encodingError):
                     print(encodingError)
                     break
             }
         }
     }*/
    
    // MARK: - Specific request
}
