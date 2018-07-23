//
//  VCBaseVM.swift
//  MVVMVideoChat
//
//  Created by Tran Manh Quy on 7/23/18.
//  Copyright © 2018 DepTrai. All rights reserved.
//

import UIKit

class VCBaseVM: NSObject {
	weak var ownerView: VCBaseVC?
	
	init(_ ownerView: VCBaseVC) {
		self.ownerView = ownerView
	}
}
