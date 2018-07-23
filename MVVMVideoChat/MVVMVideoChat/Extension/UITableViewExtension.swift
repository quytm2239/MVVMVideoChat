//
//  TableViewExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//
import UIKit

public extension UITableView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UICollectionView {
	func registerCellClass(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		self.register(cellClass, forCellWithReuseIdentifier: identifier)
	}
	
	func registerCellNib(_ cellClass: String) {
		let nib = UINib(nibName: cellClass, bundle: nil)
		self.register(nib, forCellWithReuseIdentifier: cellClass)
	}
	
	func dequeueCell(_ cellClass: String, indexPath: IndexPath) -> UICollectionViewCell {
		return self.dequeueReusableCell(withReuseIdentifier: cellClass, for: indexPath)
	}
}
