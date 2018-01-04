//
//  CartItem.swift
//  ShopingList
//
//  Created by Phat Trien TRAN (001004012) on 15/11/2017.
//  Copyright © 2017 Phat Trien TRAN (001004012). All rights reserved.
//

import Foundation

public class CartItem{
    
    public var itemName: String
    public var price: Double
    public var group:String
    public var quantity:Int
    
    //default
    public init(){
    
        self.itemName=""
        self.price=0
        self.group=""
        self.quantity=0
        
    }
    
    public init(itemName:String, price:Double,group:String, quantity:Int){
        
        self.itemName=itemName
        self.price=price
        self.group=group
        self.quantity=quantity
    }
    
    func toString() ->String{
     return ""
    }
    
    
}
