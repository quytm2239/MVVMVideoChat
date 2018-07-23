//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
	
	func canAppendToView(_ view: UIView, _ inWidth: CGFloat, _ interSpace: CGFloat) -> Bool{
		return (inWidth - (view.frame.origin.x + view.frame.size.width + interSpace + frame.size.width)) >= 0
	}
	
	func appendToView(_ view: UIView, _ interSpace: CGFloat) {
		let point: CGPoint = CGPoint(x: view.frame.origin.x + view.frame.size.width + interSpace, y: view.frame.origin.y)
		frame = CGRect(origin: point, size: frame.size)
		center = CGPoint(x: center.x, y: view.center.y)
	}
	
	func goUnderView(_ view: UIView, _ lineSpace: CGFloat) {
		let point: CGPoint = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + view.frame.size.height + lineSpace)
		frame = CGRect(origin: point, size: frame.size)
		//center = CGPoint(x: view.center.x, y: center.y)
	}
    
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    // OUTPUT 1
    func dropBottomShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
	
	// OUTPUT 1
	func dropTopShadow(scale: Bool = true) {
		layer.masksToBounds = false
		layer.shadowColor = UIColor.lightGray.cgColor
		layer.shadowOpacity = 0.5
		layer.shadowOffset = CGSize(width: 0, height: -2)
		layer.shadowRadius = 2
		
		layer.shouldRasterize = true
		layer.rasterizationScale = scale ? UIScreen.main.scale : 1
	}
    
    // OUTPUT 2
    
    func dropShadow(color: UIColor, opacity: Float = 0.7, offSet: CGSize, radius: CGFloat, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
	
	// different inner shadow styles
	public enum innerShadowSide {
		case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
	}
	
	// define function to add inner shadow
	public func addInnerShadow(onSide: innerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius: CGFloat = 0.0, shadowOpacity: Float, customFrame: CGRect?) {
		// define and set a shaow layer
		let shadowLayer = CAShapeLayer()
		shadowLayer.frame = (customFrame != nil) ? customFrame! : bounds
		shadowLayer.shadowColor = shadowColor.cgColor
		shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		shadowLayer.shadowOpacity = shadowOpacity
		shadowLayer.shadowRadius = shadowSize
		shadowLayer.fillRule = kCAFillRuleEvenOdd
		
		// define shadow path
		let shadowPath = CGMutablePath()
		
		// define outer rectangle to restrict drawing area
		let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
		
		// define inner rectangle for mask
		let innerFrame: CGRect = { () -> CGRect in
			switch onSide
			{
			case .all:
				return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
			case .left:
				return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
			case .right:
				return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
			case .top:
				return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
			case.bottom:
				return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
			case .topAndLeft:
				return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
			case .topAndRight:
				return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
			case .bottomAndLeft:
				return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
			case .bottomAndRight:
				return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
			case .exceptLeft:
				return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
			case .exceptRight:
				return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
			case .exceptTop:
				return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
			case .exceptBottom:
				return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
			}
		}()
		
		// add outer and inner rectangle to shadow path
		shadowPath.addRect(insetRect)
		shadowPath.addRect(innerFrame)
		
		// set shadow path as show layer's
		shadowLayer.path = shadowPath
		
		// add shadow layer as a sublayer
		layer.addSublayer(shadowLayer)
		
		// hide outside drawing area
		clipsToBounds = true
	}
	
	func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
		UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 1.0
		}, completion: completion)  }
	
	func fadeOutAndIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
		UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 0.5
		}, completion: { end in
			self.alpha = 1.0
			completion(end)
		})
	}
	
	func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
		UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 0.0
		}, completion: completion)
	}
}

extension UILabel {
    func changeFontSize(_ size: CGFloat) {
        font = UIFont(name: self.font.fontName, size: size)
    }
	
	func neededWidth(fromText text: String) -> CGFloat {
		self.text = text
		let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
		return size.width
	}
	
	@objc func updateWidth(fromText text: String) {
		let width = self.neededWidth(fromText: text)
		self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
	}
    
    func setTextWhileKeepingAttributes(string: String) {
        if let newAttributedText = self.attributedText {
            let mutableAttributedText = newAttributedText.mutableCopy() as! NSMutableAttributedString
            mutableAttributedText.mutableString.setString(string)
            self.attributedText = mutableAttributedText
        }
    }
    
//    func setHashTag(tags: [String]) {
//        let tagString: NSMutableAttributedString = NSMutableAttributedString()
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineBreakMode = .byWordWrapping
//        paragraphStyle.lineSpacing = 6
//        for (index, tag) in tags.enumerated() {
//            let attrSharp = [NSAttributedStringKey.font: UIFont(name: NAME_FONT_BOLD, size: 12)!, NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.foregroundColor: UIColor(hex: "#0795E0")]
//            let attrStringSharp = NSAttributedString(string: "#", attributes: attrSharp)
//            tagString.append(attrStringSharp)
//            let attr = [NSAttributedStringKey.font: UIFont(name: NAME_FONT_NORMAL, size: 12)!, NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.foregroundColor: UIColor(hex: "#0795E0")]
//            let attrString: NSAttributedString
//            if index == tags.count - 1 {
//                attrString = NSAttributedString(string: " \(tag)\n", attributes: attr)
//            } else {
//                attrString = NSAttributedString(string: " \(tag)  ", attributes: attr)
//            }
//            tagString.append(attrString)
//        }
//        self.attributedText = tagString
//    }
}

extension UIFont {
    open override var description: String {
        return "\(self.fontName) - \(self.pointSize)"
    }
    
    open override var debugDescription: String {
        return "\(self.fontName) - \(self.pointSize)"
    }
}
