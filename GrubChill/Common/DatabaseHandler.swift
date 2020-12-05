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
    
    mutating func insertCartModel(itemid: String, item : String, price: Double, pic : String, quantity : Int, description: String) -> Bool{
        do {
            let db = createDatabase()
            self.cartDataArray = [CartDTO]()
            let checkData = try db.prepare(self.usersTable)
            for cart in checkData {
                if cart[self.itemid] == itemid {
                    let category = CartDTO()
                    category.itemid = cart[self.itemid]
                    category.item = cart[self.item]
                    category.price = cart[self.price]
                    category.pic = cart[self.pic]
                    category.description = cart[self.description]
                    category.quantity = cart[self.quantity]

                    self.cartDataArray.append(category)
                }
            }
            
            if self.cartDataArray.count == 0{
                let insertUser = self.usersTable.insert(
                   self.itemid <- itemid,
                   self.item <- item,
                   self.price <- price,
                   self.pic <- pic,
                   self.quantity <- quantity,
                   self.description <- description
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
                    self.description <- description
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
            self.cartDataArray = [CartDTO]()
            let db = createDatabase()
            let cartList = try db.prepare(self.usersTable)
            for cart in cartList {
                let category = CartDTO()
                category.itemid = cart[self.itemid]
                category.item = cart[self.item]
                category.price = cart[self.price]
                category.pic = cart[self.pic]
                category.description = cart[self.description]
                category.quantity = cart[self.quantity]

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
            let user = "DELETE FROM \(usersTable) WHERE itemsID=\(itemsID)"
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
