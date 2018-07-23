//
//  VCBaseVC.swift
//  MVVMVideoChat
//
//  Created by Tran Manh Quy on 7/23/18.
//  Copyright © 2018 DepTrai. All rights reserved.
//

import UIKit

class VCBaseVC: UIViewController, VCNavigationVMProtocol {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
	
	var vmNavigation: VCNavigationVM?
	override func viewDidLoad() {
		super.viewDidLoad()
		setNeedsStatusBarAppearanceUpdate()
		vmNavigation = VCNavigationVM(self)
		title = self.objectName
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	func open(vc: VCBaseVC) {
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func close(toRoot: Bool) {
		if toRoot {
			navigationController?.popToRootViewController(animated: true)
		} else {
			navigationController?.popViewController(animated: true)
		}
	}
	
	func closeToVC(_ vc: VCBaseVC) {
		navigationController?.popToViewController(vc, animated: true)
	}
}
