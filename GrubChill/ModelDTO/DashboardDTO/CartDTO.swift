//
//  CartDTO.swift
//  GrubChill
//
//  Created by Bharath Kumar on 30/11/20.
//

import Foundation
import ObjectMapper

class CartDTO : Mappable {
   
//    "restaurantId":"1202010260502",
//    "address_id":null,
//    "couponCode":null,
//    "delivery_method":"Delivery",
    var restaurantId : String?
    var address_id : String?
    var couponCode : String?
    var delivery_method : String?
    var cartItem : [CartItemData]?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        restaurantId <- map["restaurantId"]
        address_id <- map["address_id"]
        couponCode <- map["couponCode"]
        delivery_method <- map["delivery_method"]
        cartItem <- map["cartItem"]
        
    }
}

class CartItemData: Mappable {
    
    var itemid : String?
    var item : String?
    var price : Double?
    var pic : String?
    var description : String?
    var qty : Int?
    var isactive : Bool?
    var businessid:String?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        itemid <- map["itemid"]
        item <- map["item"]
        price <- map["price"]
        pic <- map["pic"]
        qty <- map["qty"]
        description <- map["description"]
        isactive <- map["isactive"]
        businessid <- map["businessid"]
    }
}
