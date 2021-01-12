//
//  RestrauntMenuDTO.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 26/11/20.
//

import Foundation
import ObjectMapper

class RestrauntMenuDTO : Mappable {
    
    var status : String?
    var message : String?
    var errors : String?
    var data : Detaildata?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        errors <- map["errors"]
        data <- map["data"]
    }
    
}


//class MenuList : Mappable {
//
//    var businessid : String?
//    var category : String?
//    var categoryid: String?
//    var items : [ItemsArrayDTO]?
//
//    init(){ }
//
//    required init?(map: Map) { }
//
//    func mapping(map: Map) {
//        businessid <- map["businessid"]
//        category <- map["category"]
//        categoryid <- map["categoryid"]
//        items <- map["items"]
//    }
//
//}
//
//class ItemsArrayDTO : Mappable {
//    var item: String?
//    var pic: String?
//    var description:String?
//    var itemid: String?
//    var price: Double?
//    var isactive: Bool?
//    var orderid: Int?
//    var optiongroups: [String]?
//    var businessid: String?
//
//    init() { }
//
//    required init?(map: Map) { }
//
//    func mapping(map: Map) {
//        item <- map["item"]
//        pic <- map["pic"]
//        description <- map["description"]
//        itemid <- map["itemid"]
//        price <- map["price"]
//        isactive <- map["isactive"]
//        orderid <- map["orderid"]
//        optiongroups <- map["optiongroups"]
//        businessid <- map["businessid"]
//    }
//}


class Detaildata: Mappable {
    var _id : String?
    var businessid : String?
    var name : String?
    var phone: String?
    var categoryone: String?
    var categorytwo: String?
    var zipCode: String?
    var subtext: Bool?
    var logo: String?
    var email: String?
    var status: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var menu : [Menudata]?


    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        _id <- map["_id"]
        businessid <- map["businessid"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        categoryone <- map["categoryone"]
        status <- map["status"]
        categorytwo <- map["categorytwo"]
        zipCode <- map["zipCode"]
        subtext <- map["subtext"]
        logo <- map["logo"]
        address <- map["address"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
        menu <- map["menus"]

    }
    
}


class Menudata: Mappable {
    var businessid : String?
    var category : String?
    var categoryid: String?
    var items: [Itemdata]?

    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        businessid <- map["businessid"]
        category <- map["category"]
        categoryid <- map["categoryid"]
        items <- map["items"]
    }
    
}

class Itemdata: Mappable {
    var item : String?
    var pic : String?
    var description: String?
    var itemid: String?
    var price: Double?
    var isactive: String?
    var orderid: String?
    var optiongroups: [optiongroupsData]?
    var quantity: Int?
    var businessid : String?
    

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        item <- map["item"]
        pic <- map["pic"]
        description <- map["description"]
        itemid <- map["itemid"]
        price <- map["price"]
        isactive <- map["isactive"]
        orderid <- map["orderid"]
        optiongroups <- map["optiongroups"]
        businessid <- map["businessid"]
        quantity = 0
        }
}


class optiongroupsData: Mappable {
    var _id : String?
    var itemid : String?
    var optiongroupname: String?
    var optiongroupid: String?
    var options: [optionsData]?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        _id <- map["_id"]
        itemid <- map["itemid"]
        optiongroupname <- map["optiongroupname"]
        optiongroupid <- map["optiongroupid"]
        options <- map["options"]
        }
}

class optionsData: Mappable {
    var optionname : String?
    var optionid : String?
    var price: String?
    var orderid: String?
    var selected: Int?

       
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        optionname <- map["optionname"]
        optionid <- map["optionid"]
        price <- map["price"]
        orderid <- map["orderid"]
        selected <- map["0"]

        }
}
