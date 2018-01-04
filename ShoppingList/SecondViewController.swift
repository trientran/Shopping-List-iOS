//
//  SecondViewController.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 25/10/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var db: COpaquePointer = nil
    
    @IBOutlet weak var cartTable: UITableView!

    
    func selectQuery() {
        let selectQueryStatement = "SELECT * FROM shoppinglist"
        var queryStatement:COpaquePointer = nil
        
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK {
            print("Successfully opened connection to database")
            
            if(sqlite3_prepare_v2(db, selectQueryStatement, -1, &queryStatement, nil)==SQLITE_OK)
            {
                print("Query Result:")
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    let nameField = sqlite3_column_text(queryStatement,1)
                    let itemName = String.fromCString(UnsafePointer<CChar>(nameField))!
                    let price = sqlite3_column_double(queryStatement,2)
                    let groupField = sqlite3_column_text(queryStatement,3)
                    let group = String.fromCString(UnsafePointer<CChar>(groupField))!
                    let quantity = sqlite3_column_int(queryStatement,4)
                    
                    print("\(itemName) | \(price)")
                    let c=CartItem(itemName:itemName,price:Double(price),group: group, quantity:Int(quantity))
                    appDelegate.cart2.append(c)
                }
                
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
    
    func deleteQuery(itemName:String){
        let deleteSQL = "DELETE FROM shoppinglist WHERE item = ('\(itemName)')"
        print(deleteSQL)
        var queryStatement: COpaquePointer = nil
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK
        {
            print("Successfully opened connection to database ")
            if (sqlite3_prepare_v2(db, deleteSQL, -1, &queryStatement, nil) == SQLITE_OK)
            {
                
                if sqlite3_step(queryStatement) == SQLITE_DONE{
                    print("Record Deleted!")
                }
                else{
                    print("Fail to Delete")
                }
                sqlite3_finalize(queryStatement)
                
            }
            else {
                print("Delete statement could not be prepared")
            }
            sqlite3_close(db)
            
        }
        else{
            print("Unable to open database")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) ->Int{ return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{ return appDelegate.cart2.count}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        
        let c:CartItem=appDelegate.cart2[indexPath.row]
        cell.textLabel!.text=c.itemName
        cell.detailTextLabel!.text=String(format:"Price: %0.2f  Qty: %0.2d",c.price, c.quantity)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        //Return false if you don't want the specified item
        return true
        
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath) {
        
        if(editingStyle==UITableViewCellEditingStyle.Delete){
            // delete from db
            let selectedItem:CartItem = appDelegate.cart2[indexPath.row]
            let itemName:String = selectedItem.itemName
            deleteQuery(itemName)
            // delete from the array and the table
            appDelegate.cart2.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        if(editingStyle==UITableViewCellEditingStyle.Insert){
            //Create a new instance of the appropriate class, insert it into the array and add a new row to the table view
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            selectQuery()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        appDelegate.cart2.removeAll()
        selectQuery()
        cartTable.reloadData()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

