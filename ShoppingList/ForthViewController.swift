//
//  SecondViewController.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 25/10/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var db: COpaquePointer = nil
    
    @IBOutlet weak var tableAddress: UITableView!
    
    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var inputStreet: UITextField!
    @IBOutlet weak var inputSuburb: UITextField!
    @IBOutlet weak var inputState: UITextField!
    @IBOutlet weak var inputCountry: UITextField!
    
    @IBAction func addButton(sender: UIButton) {
        
        var street:String?
        var suburb:String?
        var state:String?
        var country:String?
        
        street = inputStreet.text
        suburb = inputSuburb.text
        state = inputState.text
        country = inputCountry.text
        print(street! + suburb! + state! + country!)
        insertQuery(street!, suburb: suburb!, state: state!, country: country!)
        
        appDelegate.addressList.removeAll()
        
        //run the select query
        selectQuery()
        tableAddress.reloadData()


    }

    @IBAction func updateBtnClick(sender: UIButton) {
        
        var id:Int?
        var street:String?
        var suburb:String?
        var state:String?
        var country:String?
        
        id = Int(inputID.text!)
        street = inputStreet.text
        suburb = inputSuburb.text
        state = inputState.text
        country = inputCountry.text
        
        print(street! + suburb! + state! + country!)
        updateQuery(id!, street: street!, suburb: suburb!, state: state!, country: country!)
        
        appDelegate.addressList.removeAll()
        
        //run the select query
        selectQuery()
        tableAddress.reloadData()
        

    }
    
    func insertQuery(street:String,suburb:String, state:String,country:String) ->Bool{
        
        var result:Bool = false
        
        let insertSQL = "Insert into addresslist(street,suburb, state, country) VALUES ('\(street)','\(suburb)','\(state)','\(country)')"
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
            else {
                print("Insert statement could not be prepared")
            }
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
        }
        return result
    }
    
    func updateQuery(id:Int, street:String,suburb:String, state:String,country:String) ->Bool{
        
        var result:Bool = false
        
        let updateSQL = "UPDATE addresslist SET street = '\(street)', suburb = '\(suburb)', state = '\(state)', country = '\(country)' where id = \(id) "
        
        print(updateSQL)
        var queryStatement:COpaquePointer = nil
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK
        {
            print("Successfully opened connection to database", terminator:"")
            if (sqlite3_prepare_v2(db, updateSQL, -1, &queryStatement, nil) == SQLITE_OK)
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
            else {
                print("Insert statement could not be prepared")
            }
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
        }
        return result
    }

    
    func selectQuery() {
        let selectQueryStatement = "SELECT * FROM addresslist"
        var queryStatement:COpaquePointer = nil
        
        if sqlite3_open(appDelegate.getDBPath(),&db) == SQLITE_OK{
            print("Successfully opened connection to database")
            
        if(sqlite3_prepare_v2(db, selectQueryStatement, -1, &queryStatement, nil)==SQLITE_OK)
        {
            print("Query Result:")
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                
                let id = sqlite3_column_int(queryStatement,0)
            
                
                let streetF = sqlite3_column_text(queryStatement,1)
                let street = String.fromCString(UnsafePointer<CChar>(streetF))!
                
                let suburbF = sqlite3_column_text(queryStatement,2)
                let suburb = String.fromCString(UnsafePointer<CChar>(suburbF))!
                
                let stateF = sqlite3_column_text(queryStatement,3)
                let state = String.fromCString(UnsafePointer<CChar>(stateF))!
                
                let countryF = sqlite3_column_text(queryStatement,4)
                let country = String.fromCString(UnsafePointer<CChar>(countryF))!
                
                let a=Address(id:Int(id), street:street, suburb:suburb, state:state, country:country)
                appDelegate.addressList.append(a)
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
    
    func deleteQuery(id:Int){
        let deleteSQL = "DELETE FROM addresslist WHERE id = '\(id)'"
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{ return appDelegate.addressList.count}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        
        let c:Address=appDelegate.addressList[indexPath.row]
        cell.textLabel!.text=c.toString()
        // cell.detailTextLabel!.text=c.toString()
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        //Return false if you don't want the specified item
        return true
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath) {
        
        if(editingStyle==UITableViewCellEditingStyle.Delete){
            // delete from db
            let selectedItem:Address = appDelegate.addressList[indexPath.row]
            let id:Int = selectedItem.id
            deleteQuery(id)
            // delete from the array and the table
            appDelegate.addressList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        if(editingStyle==UITableViewCellEditingStyle.Insert){
            //Create a new instance of the appropriate class, insert it into the array and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem:Address = appDelegate.addressList[indexPath.row]
        
        inputID.text = String(selectedItem.id)
        inputStreet.text = selectedItem.street
        inputSuburb.text = selectedItem.suburb
        inputState.text = selectedItem.state
        inputCountry.text = selectedItem.country
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            selectQuery()
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        appDelegate.addressList.removeAll()
        
            //run the select query
            selectQuery()
        tableAddress.reloadData()
            super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

