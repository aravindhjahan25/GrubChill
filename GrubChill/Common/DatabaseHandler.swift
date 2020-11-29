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
    let itemid = Expression<Int>("itemid")
    let item = Expression<String>("item")
    let price = Expression<String>("price")
    let orderid = Expression<String>("orderid")
    let pic = Expression<String>("pic")
    let quantity = Expression<Int>("quantity")
    let description = Expression<String>("description")
    let isFavourite = Expression<Bool>("isFavourite")
    let isActive = Expression<Bool>("isActive")
    let optiongroupname = Expression<String>("optiongroupname")
    let optiongroupid = Expression<String>("optiongroupid")
    let optionname = Expression<String>("optionname")
    let optionid = Expression<String>("optionid")
    let optionprice = Expression<String>("optionprice")

    
    var cartDataArray = [CartDTO]()
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
    
    func createTable(){
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.itemid)
            table.column(self.item)
            table.column(self.price)
            table.column(self.description)
            table.column(self.pic)
            table.column(self.quantity)
            table.column(self.orderid)
            table.column(self.isFavourite)
            table.column(self.isActive)
            table.column(self.optiongroupid)
            table.column(self.optiongroupname)
            table.column(self.optionname)
            table.column(self.optionid)
            table.column(self.optionprice)

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
    
    mutating func insertCartModel(itemid: Int, item : String, price: String, orderid : String, pic : String, quantity : Int, description: String, isFavourite : Bool, isActive : Bool, optiongroupid : String, optiongroupname : String, optionname : String, optionid : String, optionprice : String) -> Bool{
         let insertUser = self.usersTable.insert(
            self.itemid <- itemid,
            self.item <- item,
            self.price <- price,
            self.pic <- pic,
            self.orderid <- orderid,
            self.quantity <- quantity,
            self.description <- description,
            self.isFavourite <- isFavourite,
            self.isActive <- isActive,
            self.optiongroupid <- optiongroupid,
            self.optiongroupname <- optiongroupname,
            self.optionname <- optionname,
            self.optionid <- optionid,
            self.optionprice <- optionprice
        )
        do {
            let db = createDatabase()
            try db.run(insertUser)
            print("INSERTED cart element")
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    mutating func getCartModelList() -> [CartDTO]{
        do {
            self.cartDataArray = [CartDTO]()
            let db = createDatabase()
            let cartList = try db.prepare(self.usersTable)
            for cart in cartList {
                let category = CartDTO()
//                category.itemid = cart[self.itemid]
                category.item = cart[self.item]
                category.price = cart[self.price]
                category.pic = cart[self.pic]
                category.description = cart[self.description]
//                category.quantity = cart[self.quantity]
//                category.isActive = cart[self.isActive]
//                category.isFavourite = cart[self.isFavourite]
//                category.isActive = cart[self.isActive]

                self.cartDataArray.append(category)
            }
        } catch {
            print(error)
        }

        return cartDataArray
    }
    
    mutating func deleteCartData(itemsID : Int) -> Bool{
        do {
            let db = createDatabase()
            let user = "DELETE FROM cartModel WHERE itemsID=\(itemsID)"
            let deleteUser = try db.run(user)
            print(deleteUser)
            return true
        } catch {
            print(error)
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
            
            let total = qinHand.reduce(0, +)

            
            return total
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
