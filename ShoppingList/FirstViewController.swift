//
//  FirstViewController.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 25/10/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var priceInput: UITextField!
    @IBOutlet weak var quantityInput: UITextField!
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var statusText: UILabel!
    
    var groupArray: [String] = ["Grocery", "Tech", "Books", "Clothing", "Other"]
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var db: COpaquePointer = nil
    
    
    @IBAction func addItemAction(sender: UIButton) {
        var itemName:String?
        var itemPrice:Double?
        var itemQty:Int?
        var itemGroup:String?
        
        itemName = nameInput.text
        itemPrice = NSString(string:priceInput.text!).doubleValue
        itemGroup = groupArray[groupPicker.selectedRowInComponent(0)]
        itemQty = NSString(string:quantityInput.text!).integerValue
        
        print(itemGroup!)
       insertQuery(itemName!, price: itemPrice!, group: itemGroup!, quantity: itemQty!)
        
        let c = CartItem(itemName:itemName!,price:itemPrice!, group: itemGroup!, quantity: itemQty!)
        appDelegate.cart.append(c)
        statusText.text = "Record Added"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addButton.layer.cornerRadius = 4
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupArray.count;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String! {
        return groupArray[row]
    }

    
    func insertQuery(itemName:String,price:Double, group:String,quantity:Int) ->Bool{
        
        var result:Bool = false
        
        let insertSQL = "Insert into shoppinglist(item,price, `group`, quantity) VALUES ('\(itemName)',\(price),'\(group)',\(quantity))"
        print(insertSQL)
        var queryStatement:COpaquePointer = nil
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK
        {
        print("Successfully opened connection to database", terminator:"")
        if (sqlite3_prepare_v2(db, insertSQL, -1, &queryStatement, nil) == SQLITE_OK)
        {
            if sqlite3_step(queryStatement) == SQLITE_DONE{
                print("Record Inserted!")
                result = true
            }
            else{
                print("Fail to Insert")
            }
            sqlite3_finalize(queryStatement)
        }
        else{
            print("Insert statement could not be prepared")
        }
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
        }
        return result
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

