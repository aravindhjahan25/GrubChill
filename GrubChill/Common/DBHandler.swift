//
//  DBHandler.swift
//  centaur
//
//  Created by Aravindh Jaganathan on 12/08/20.
//  Copyright © 2020 Aravindh Jaganathan. All rights reserved.
//

import Foundation
import SQLite3

//Expense table
let TBL_EXPENSE = "cartModel"
let id = "id"
let itemsID = "itemsID"
let name = "name"
let price = "price"
let product = "product"
let image = "image"
let qtyInHand = "qtyInHand"
let desc = "desc"

class DBHandler: NSObject {

    var fileManager: FileManager?
    var databasePath: String = ""
    private var database: OpaquePointer? = nil
    private var statement: OpaquePointer? = nil
    
    override init() {
          fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
          let docsPath = paths[0]
          databasePath = URL(fileURLWithPath: docsPath).appendingPathComponent("Expenses").absoluteString
          print("DB Path : \(databasePath)")
      }
    
    func openDatabaseConnection() -> Bool {
        if sqlite3_open(databasePath, &database) == SQLITE_OK {
            return true
        }
           
        return false
    }
    
    func closeDatabaseConnection() {
        sqlite3_close(database)
    }
    
    func createDB() {
        if fileManager?.fileExists(atPath: databasePath) == false {
            createTable()
        } else {
            if fileManager?.fileExists(atPath: databasePath) == true {
                print("Database Already Exists.")
                createTable()
            } else {
                print("Error : \(String(describing: sqlite3_errmsg(database)))")
                print("Database Not Created / Opened.")
            }
        }
    }
    
    func createTable() {
        defer {
            closeDatabaseConnection()
        }
        do {
            if openDatabaseConnection() {
               // Expense table
                let CREATE_TABLE = "CREATE TABLE IF NOT EXISTS \(TBL_EXPENSE) (\(id) INTEGER PRIMARY KEY AUTOINCREMENT, \(itemsID) INTEGER, \(name) TEXT, \(price) TEXT, \(product) TEXT, \(image) LONG TEXT, \(qtyInHand) INTEGER, \(desc) TEXT"
                print(CREATE_TABLE)
                if sqlite3_exec(database, CREATE_TABLE, nil, nil, nil) != SQLITE_OK {
                    print("CREATE_TABLE Table Error : \(String(describing: sqlite3_errmsg(database)))")
                } else {
                    print("CREATE_TABLE Table Created")
                }
            }
        }
        closeDatabaseConnection()
    }
    
    func clearDatabase() {
        if fileManager?.fileExists(atPath: databasePath) == true {
            let error: Error? = nil
            try? fileManager?.removeItem(atPath: databasePath)
            assert(error == nil, "Assertion: SQLite file deletion shall never throw an error.")
            if error == nil {
                createDB()
            }
        }
    }
    
    func GetCartData() -> [Itemdata] {
        var arr = [Itemdata]()
        defer {
            closeDatabaseConnection()
        }
        do {
            if openDatabaseConnection() {
                let select_stmt = "SELECT * FROM \(TBL_EXPENSE)"
                print(select_stmt)
                if sqlite3_prepare_v2(database, select_stmt, -1, &statement, nil) == SQLITE_OK {
                    while sqlite3_step(statement) == SQLITE_ROW {
                        let model = Itemdata()
                        model.itemid = String(sqlite3_column_int(statement, 1))
                        model.item = String(cString: sqlite3_column_text(statement, 1)!)
                        model.description = String(cString: sqlite3_column_text(statement, 2)!)
                        model.pic = String(cString: sqlite3_column_text(statement, 3)!)
                        model.price = Double(Int(bitPattern: sqlite3_column_text(statement, 4)!))
                        model.quantity = Int(sqlite3_column_int(statement, 5))
                        model.description = String(cString: sqlite3_column_text(statement, 6)!)
                        arr.append(model)
                    }
                    sqlite3_reset(statement)
                }
                return arr
            }
            closeDatabaseConnection()
            return arr
        }
    }
    
    func insertData(itemsID: Int, name : String, price: String, product : String, image : String, qtyInHand : Int, description: String) -> Bool {
           var result = false
           defer {
               closeDatabaseConnection()
           }
           do {
               if openDatabaseConnection() {
                   var Data_stmt: String? = nil
                   Data_stmt = "INSERT INTO \(TBL_EXPENSE) (\(itemsID),\(name),\(price),\(product),\(image), \(qtyInHand), \(description) VALUES (\(itemsID)',\'\(name)\',\'\(price)\',\'\(product)\',\'\(image)\', \(qtyInHand), ,\'\(desc)\'"
                   print(Data_stmt as Any)
                   sqlite3_prepare_v2(database, Data_stmt, -1, &statement, nil)
                   if sqlite3_step(statement) == SQLITE_DONE {
                       print("insert sucessfully")
                       result = true
                   } else {
                       print("insert not sucessfully")
                       result = false
                   }
                   sqlite3_reset(statement)
               }
           }
           closeDatabaseConnection()
           return result
       }
    
    func DeleteFromID(itemsID: Int) -> Bool {
           var result = false
           defer {
               closeDatabaseConnection()
           }
           do {
               if openDatabaseConnection() {
                   let Data_stmt = "DELETE FROM \(TBL_EXPENSE) WHERE \(itemsID) = \'\(itemsID)\'"
                   print(Data_stmt)
                   sqlite3_prepare_v2(database, Data_stmt, -1, &statement, nil)
                   
                   if sqlite3_step(statement) == SQLITE_DONE {
                       print("Data deleted.")
                       result = true
                   } else {
                       print("Data Not deleted. Error \(String(describing: sqlite3_errmsg(database)))")
                       result = false
                   }
                   sqlite3_reset(statement)
                   return result
               }
               closeDatabaseConnection()
               return result
           }
       }

}
