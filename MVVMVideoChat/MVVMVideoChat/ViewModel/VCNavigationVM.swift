//
//  VCNavigationVM.swift
//  MVVMVideoChat
//
//  Created by Tran Manh Quy on 7/23/18.
//  Copyright © 2018 DepTrai. All rights reserved.
//

import UIKit
protocol VCNavigationVMProtocol {
	func open(vc: VCBaseVC)
	func close(toRoot: Bool)
	func closeToVC(_ vc: VCBaseVC)
}

class VCNavigationVM: VCBaseVM {
//	func openStartWorkOut() {
//		let vc = UIStartWorkoutVC(nibName: UIStartWorkoutVC.typeName, bundle: nil)
//		ownerView?.open(vc: vc)
//	}
}
