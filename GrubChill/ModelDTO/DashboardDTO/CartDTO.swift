//
//  CartDTO.swift
//  GrubChill
//
//  Created by Bharath Kumar on 30/11/20.
//

import Foundation
import ObjectMapper

class CartDTO : Mappable {
    
    var itemid : String?
    var item : String?
    var price : Double?
    var pic : String?
    var description : String?
    var quantity : Int?
//    var isFavourite : String?
//    var isActive : String?
//    var optiongroupname : String?
//    var optiongroupid : String?
//    var optionname : String?
//    var optionid : String?
//    var optionprice : String?
//
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        itemid <- map["itemid"]
        item <- map["item"]
        price <- map["price"]
        pic <- map["pic"]
        quantity <- map["quantity"]
        description <- map["description"]
        quantity <- map["quantity"]
    }
}
