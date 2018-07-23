//
//  UserDefaults.swift
//  TourDe
//
//  Created by Tran Manh Quy on 4/4/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit

let TOKEN = "token"
let EMAIL = "email"
let PASSWORD = "password"
let SNS_GPLUS = "sns_gplus"
let SNS_FB = "sns_fb"
let SNS_TWITTER = "sns_twitter"
let SNS_LINE = "sns_line"
let SNS_CURRENT_KIND = "sns_current_kind"
let IS_FIRST_RUN = "is_first_run"
let NEED_SHOW_TUTORIAL = "need_show_tutorial"
let NEED_SHOW_TERM = "need_show_term"
let USER_INFORMATION = "user_information"
let LOGGING_COURSE = "logging_course"
extension UserDefaults {
	
	class func saveToken(token: String) {
		UserDefaults.standard.setValue(token, forKey: "token")
	}
	
	class func loadToken() -> String? {
		return UserDefaults.standard.object(forKey: "token") as? String
	}
	
	class func removeToken() {
		return UserDefaults.standard.removeObject(forKey: "token")
	}
	
	// MARK: - Persist data
	func saveIsFirstRun(_ isFirstRun: Bool) {
		self.set(isFirstRun, forKey: IS_FIRST_RUN)
		self.synchronize()
	}
    
    func saveIsLogging(_ isLogging: Bool){
        self.set(isLogging, forKey: LOGGING_COURSE)
        self.synchronize()
    }
    
    func saveUserInformation(_ profilePicture:String, _ name:String, _ email:String){
        let myDict = [
            "profile_picture": profilePicture,
            "name": name,
            "email": email
        ] as [String:Any]
        self.set(myDict, forKey: USER_INFORMATION)
        self.synchronize()
    }
    
    func saveToken(_ tokenString: String) {
        NotificationCenter.default.post(name: Notification.Name(TDNotifyChangeLoginStatus), object: nil)
        self.set(tokenString, forKey: TOKEN)
        self.synchronize()
    }
    
    func saveDeviceToken(_ deviceToken: String) {
        self.set(deviceToken, forKey: "deviceToken")
        self.synchronize()
    }
    
	func saveEmail(_ email: String) {
		self.set(email, forKey: EMAIL)
		self.synchronize()
	}
    
	func savePassword(_ password: String) {
		self.set(password, forKey: PASSWORD)
		self.synchronize()
	}
    
    func saveNeedShowTutorial(_ needShowTutorial: Bool) {
        self.set(needShowTutorial, forKey: NEED_SHOW_TUTORIAL)
        self.synchronize()
    }
    func saveNeedShowTerm(_ needShowTerm: Bool) {
        self.set(needShowTerm, forKey: NEED_SHOW_TERM)
        self.synchronize()
    }

	// MARK: - Persist SNS data
	func saveSnsID(_ id: String, _ kind: SnsKind) {
		switch kind {
		case .Facebook:
			self.set(id, forKey: SNS_FB)
		case .Twitter:
			self.set(id, forKey: SNS_TWITTER)
		case .Google:
			self.set(id, forKey: SNS_GPLUS)
		case .LINE:
			self.set(id, forKey: SNS_LINE)
		case .None:
			break
		}
		self.saveSnsCurrentKind(kind)
		self.synchronize()
	}
	
	func saveSnsCurrentKind(_ kind: SnsKind) {
		self.set(kind.rawValue, forKey: SNS_CURRENT_KIND)
	}
	
    // MARK: - Get persisted data
	func isFirstRun() -> Bool{
		guard self.object(forKey: IS_FIRST_RUN) != nil else {
			return true
		}
		return self.object(forKey: IS_FIRST_RUN) as! Bool
	}
    func getToken() -> String{
        guard self.object(forKey: TOKEN) != nil else {
            return ""
        }
        return self.object(forKey: TOKEN) as! String
    }
    
    func getLoggingStatus() -> Bool{
        guard self.object(forKey: LOGGING_COURSE) != nil else {
            return false
        }
        return self.object(forKey: LOGGING_COURSE) as! Bool
    }
    
    func getUserInformation() -> [String:Any]{
        guard self.object(forKey: USER_INFORMATION) != nil else {
            return [:]
        }
        return self.object(forKey: USER_INFORMATION) as! [String:Any]
    }
    
    func getEmail() -> String{
        guard self.object(forKey: EMAIL) != nil else {
            return ""
        }
        return self.object(forKey: EMAIL) as! String
    }
    func getPassword() -> String{
        guard self.object(forKey: PASSWORD) != nil else {
            return ""
        }
        return self.object(forKey: PASSWORD) as! String
    }
	func getDeviceToken() -> String{
		guard self.object(forKey: "deviceToken") != nil else {
			return ""
		}
		return self.object(forKey: "deviceToken") as! String
	}
    func needShowTutorial() -> Bool{
        guard self.object(forKey: NEED_SHOW_TUTORIAL) != nil else {
            return true
        }
        return self.object(forKey: NEED_SHOW_TUTORIAL) as! Bool
    }
    
    func needShowTerm() -> Bool{
        guard self.object(forKey: NEED_SHOW_TERM) != nil else {
            return true
        }
        return self.object(forKey: NEED_SHOW_TERM) as! Bool
    }
	
	// MARK: - Get persisted SNS data
	func getSnsID(kind: SnsKind) -> Int {
		switch kind {
		case .Facebook:
			return self.object(forKey: SNS_FB) as? Int ?? NO_EXIST_INT
		case .Twitter:
			return self.object(forKey: SNS_TWITTER) as? Int ?? NO_EXIST_INT
		case .Google:
			return self.object(forKey: SNS_GPLUS) as? Int ?? NO_EXIST_INT
		case .LINE:
			return self.object(forKey: SNS_LINE) as? Int ?? NO_EXIST_INT
		case .None:
			return NO_EXIST_INT
		}
	}
	
	func getSnsCurrentKind() -> SnsKind {
		if let kindRawValue = self.object(forKey: SNS_CURRENT_KIND) as? Int {
			if let kind = SnsKind(rawValue: kindRawValue) {
				return kind
			}
		}
		return .None
	}
	
    // MARK: - Remove all data
    func removeNormalData(){
        self.removeObject(forKey: TOKEN)
		self.removeObject(forKey: EMAIL)
		self.removeObject(forKey: PASSWORD)
		self.synchronize()
    }
	
	// MARK: - Remove all data
	func removeSNSData(){
		self.removeObject(forKey: TOKEN)
		self.removeObject(forKey: SNS_FB)
		self.removeObject(forKey: SNS_TWITTER)
		self.removeObject(forKey: SNS_GPLUS)
		self.removeObject(forKey: SNS_LINE)
		self.removeObject(forKey: SNS_CURRENT_KIND)
		self.synchronize()
	}
}
