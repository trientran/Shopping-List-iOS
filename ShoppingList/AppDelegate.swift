//
//  AppDelegate.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 25/10/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var cart:[CartItem] = []
    var cart2:[CartItem] = []
    
    var addressList:[Address] = []
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        copyDatabase()
        return true
    }
    
    //Read the database path from the project
    func getDBPath()->String
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,true)
        let documentsDir = paths[0]
        let databasePath = (documentsDir as NSString).stringByAppendingPathComponent("DBShoppingList.db")
        return databasePath;
        
    }
    
    //copy the database from the project to the device
    func copyDatabase()
    {
        let fileManager = NSFileManager.defaultManager()
        let dbPath = getDBPath()
        
        var success = fileManager.fileExistsAtPath(dbPath)
        
        if(!success){
            if let defaultDBPath = NSBundle.mainBundle().pathForResource("DBShoppingList", ofType: "db"){
                var error: NSError?
                do{
                    try fileManager.copyItemAtPath(defaultDBPath, toPath: dbPath)
                    success=true
                }
                catch let error1 as NSError{
                    error=error1
                    success=false
                }
                print(defaultDBPath)
                if(!success){
                    print("Failed to create writable database file with message\(error!.localizedDescription))")
                }
                
            }else{
                print("can't find file in NSBundle")
            }
        }else {
            print("File already exist at:\(dbPath)")
            
        }
        
        
    }
    


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

