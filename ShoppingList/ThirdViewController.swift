//
//  SecondViewController.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 25/10/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ThirdViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var db: COpaquePointer = nil
    
    var sum:Double = 0

    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func onEmailClicked(sender: UIButton) {
    
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController (title: "Could Not Send Email", message: "Your device could not send email. Please check email configuration and try again.", preferredStyle:.Alert)
            let alertAction = UIAlertAction(title:"OK", style:.Default,handler:nil)
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }

    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["admin@tafesait.org"])
        mailComposerVC.setSubject("In App Email")
        mailComposerVC.setMessageBody("This is a test mail", isHTML: false)
        return mailComposerVC
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }


    func selectQuery() {
        let selectQueryStatement = "SELECT price, quantity FROM shoppinglist"
        var queryStatement:COpaquePointer = nil
        
        // Do any additional setup after loading the view, typically from a nib.
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK{
            print("Successfully opened connection to database")
            
        if(sqlite3_prepare_v2(db, selectQueryStatement, -1, &queryStatement, nil)==SQLITE_OK)
        {
            print("Query Result:")
            
            
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            
                let price = sqlite3_column_double(queryStatement,0)
                let quantity = sqlite3_column_int(queryStatement,1)
        
                print("\(quantity) | \(price)")
                
                sum = sum + (price * Double(quantity))
            }
            
            sumLabel.text = String(format:"$ %0.2f", sum)
            sum = 0
        }
        else{
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        // sqlite3_close(db)
        }
        else{
            print("Unable to open database")
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK{
            print("Successfully opened connection to database")
            //run the select query
            selectQuery()
        }
        else{
            print("Unable to open database")
        }
        
   }
    
    
    override func viewWillAppear(animated: Bool) {
      

            selectQuery()
            super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

