//
//  TDAddLogDialog.swift
//  TourDe
//
//  Created by Tran Manh Quy on 4/4/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit

class TDAddLogDialog: TDBaseDialog {

    @IBOutlet weak var mainDialog: UIView!
    
    @IBOutlet weak var labelTitleAddMoneyLog: UILabel!
    @IBOutlet weak var textFieldSpentMoney: UITextField!
    @IBOutlet weak var textFieldSpentDetail: UITextField!
    @IBOutlet weak var buttonAddLog: UIButton!
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainDialog.layer.cornerRadius = 5.0
        self.buttonAddLog.layer.cornerRadius = 5.0
        self.mainContentView = mainDialog
        textFieldSpentMoney.text = name
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
    
    @IBAction func actionAddLog(_ sender: Any) {
        
        self.dismiss()
    }
    
    @IBAction func actionClickUnder(_ sender: Any) {
        self.dismiss()
    }

}
