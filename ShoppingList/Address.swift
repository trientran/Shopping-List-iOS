//
//  Address.swift
//  ShoppingList
//
//  Created by Phat Trien Tran on 17/11/17.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import Foundation
public class Address{
    
    public var id: Int
    public var street: String
    public var suburb: String
    public var state:String
    public var country:String
    
    //default
    public init(){
        self.id = 1
        self.street=""
        self.suburb=""
        self.state=""
        self.country=""
        
    }
    
    public init(id:Int, street:String, suburb:String,state:String, country:String){
        self.id = id
        self.street=street
        self.suburb=suburb
        self.state=state
        self.country=country
    }
    
    func toString() ->String{
        return street + " " + suburb + " " + state + " " + country
    }
    
    
}