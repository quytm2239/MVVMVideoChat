//
//  TDOkDialog.swift
//  TourDe
//
//  Created by Hoàng Huỳnh Mẫn on 6/8/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit

class TDOkDialog: TDBaseDialog {
    @IBOutlet weak var mainDialog: UIView!
    @IBOutlet weak var titleAlert: UILabel!
    
    @IBOutlet weak var dialogHeight: NSLayoutConstraint!
    
    @IBAction func actionOK(_ sender: Any) {
        self.dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.onClickOK?()
        }
    }
    
    var onClickOK:(()->Void)?
    
    func setText(_ text: String) {
        if let mutableString = titleAlert.attributedText as? NSMutableAttributedString {
            mutableString.mutableString.setString(text)
        }
    }
    
    func setHeight(_ height: CGFloat) {
        dialogHeight.constant = height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainContentView = mainDialog
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
