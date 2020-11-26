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
    var data : [MenuList]?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        errors <- map["errors"]
        data <- map["data"]
    }
    
}


class MenuList : Mappable {
    
    var businessid : String?
    var category : String?
    var categoryid: String?
    var items : [ItemsArrayDTO]?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        businessid <- map["businessid"]
        category <- map["category"]
        categoryid <- map["categoryid"]
        items <- map["items"]
    }
    
}

class ItemsArrayDTO : Mappable {
    var item: String?
    var pic: String?
    var description:String?
    var itemid: String?
    var price: Double?
    var isactive: Bool?
    var orderid: Int?
    var optiongroups: [String]?
    var businessid: String?
    
    init() { }
    
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
    }
}
