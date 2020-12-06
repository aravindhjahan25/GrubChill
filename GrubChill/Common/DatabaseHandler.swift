//
//  DatabaseHandler.swift
//  centaur
//
//  Created by Aravindh Jaganathan on 05/08/20.
//  Copyright © 2020 Aravindh Jaganathan. All rights reserved.
//

import Foundation
import SQLite

public struct DatabaseHandler {
 
    var database: Connection!
    
    let usersTable = Table("cartModel")
    
    let id = Expression<Int>("id")
    let itemid = Expression<String>("itemid")
    let item = Expression<String>("item")
    let price = Expression<Double>("price")
    let pic = Expression<String>("pic")
    let quantity = Expression<Int>("quantity")
    let description = Expression<String>("description")
    let isactive = Expression<String>("isactive")
    let businessid = Expression<String>("businessid")
    let delivery_method = Expression<String>("delivery_method")
    let restaurantId = Expression<String>("restaurantId")



    var OverallCart = [CartDTO]()
    var cartDataArray = [CartItemData]()
    var qinHand = [Int]()
    
    mutating func createDatabase() -> Connection{
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("GrubChill").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            self.database = db
            createTable()
            print("Database Created")
        } catch {
            print(error)
        }
        
        return self.database
    }
    
//    "restaurantId":"1202010260502",
//        "address_id":null,
//        "couponCode":null,
//        "delivery_method":"Delivery",

    
    func createTable(){
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.itemid)
            table.column(self.item)
            table.column(self.price)
            table.column(self.isactive)
            table.column(self.businessid)
            table.column(self.description)
            table.column(self.pic)
            table.column(self.quantity)
            table.column(self.delivery_method)
            table.column(self.restaurantId)
        }
              
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    func getDB() -> Connection{
        return self.database
    }
    
    mutating func insertCartModel(itemid: String, item : String, price: Double, pic : String, quantity : Int, description: String, isactive: String, businessid: String, restaurantId: String, delivery_method: String) -> Bool{
        do {
            let db = createDatabase()
            self.cartDataArray = [CartItemData]()
            self.OverallCart = [CartDTO]()

            let checkData = try db.prepare(self.usersTable)
            for cart in checkData {
                if cart[self.itemid] == itemid {
                    let category = CartItemData()
                    category.itemid = cart[self.itemid]
                    category.item = cart[self.item]
                    category.price = cart[self.price]
                    category.pic = cart[self.pic]
                    category.description = cart[self.description]
                    category.quantity = cart[self.quantity]
                    category.businessid = cart[self.businessid]
                    category.isactive = cart[self.isactive]
                    
                    OverallCart[0].restaurantId = cart[self.restaurantId]
                    OverallCart[0].delivery_method = cart[self.delivery_method]
                    self.cartDataArray.append(category)
                }
                OverallCart[0].cartItem = self.cartDataArray

            }

            
            if self.cartDataArray.count == 0{
                let insertUser = self.usersTable.insert(
                   self.itemid <- itemid,
                   self.item <- item,
                   self.price <- price,
                   self.pic <- pic,
                   self.quantity <- quantity,
                   self.description <- description,
                    self.businessid <- businessid,
                    self.isactive <- isactive,
                    self.restaurantId <- restaurantId,
                    self.delivery_method <- delivery_method
               )
                try db.run(insertUser)
                print("INSERTED cart element")
            }else{
                let updateUser = self.usersTable.update(
                    self.itemid <- itemid,
                    self.item <- item,
                    self.price <- price,
                    self.pic <- pic,
                    self.quantity <- quantity,
                    self.description <- description,
                    self.businessid <- businessid,
                    self.isactive <- isactive,
                    self.restaurantId <- restaurantId,
                    self.delivery_method <- delivery_method
                )
                try db.run(updateUser)
                print("Update cart element")
            }
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    mutating func getCartModelList() -> [CartDTO]{
        do {
            self.cartDataArray = [CartItemData]()
            self.OverallCart = [CartDTO]()

            var restaurantIdLab :String = ""
            var delivery_methodLab :String = ""


            let db = createDatabase()
            let cartList = try db.prepare(self.usersTable)
            for cart in cartList {
                let category = CartItemData()
                category.itemid = cart[self.itemid]
                category.item = cart[self.item]
                category.price = cart[self.price]
                category.pic = cart[self.pic]
                category.description = cart[self.description]
                category.quantity = cart[self.quantity]
                category.businessid = cart[self.businessid]
                category.isactive = cart[self.isactive]
                restaurantIdLab = cart[self.restaurantId]
                delivery_methodLab = cart[self.delivery_method]
                
                self.cartDataArray.append(category)
            }
            if(self.cartDataArray.count != 0 ){
                OverallCart[0].restaurantId = restaurantIdLab
                OverallCart[0].delivery_method = delivery_methodLab
                OverallCart[0].cartItem = self.cartDataArray
            }
        } catch {
            print(error)
        }

        return OverallCart
    }
    
    mutating func deleteCartData(itemsID : String) -> Bool{
        do {
            let db = createDatabase()
            let user = "DELETE FROM cartModel WHERE itemid=\"\(itemsID)\""
            let deleteUser = try db.run(user)
            
            print("deleteUserdeleteUser----->\(deleteUser)")
            return true
        } catch {
            print("error----->\(error)")
            return false
        }
    }
    
    mutating func getCartCount() -> Int{
        do{
            qinHand = [Int]()
            let db = createDatabase()
            let qList = try db.prepare(self.usersTable)
            for index in qList{
                qinHand.append(contentsOf: [index[self.quantity]])
            }
            
            //let total = qinHand.reduce(0, +)
            return qinHand.count
        }catch {
            print(error)
            return 0
        }
    }
    
    mutating func deleteAllItems() -> Bool{
        
        do{
            let db = createDatabase()
            let deleteQuery = self.usersTable.delete()
            try db.run(deleteQuery)
            print("DELETE ALL DATA")
            return true
        }catch {
           print(error)
            return false
        }
    }

}
