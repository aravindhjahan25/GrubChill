//
//  CartResponseDTO.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 20/12/20.
//

import Foundation
import ObjectMapper

class CartResponseDTO : Mappable {
    var status : String?
    var errors : String?
    var message : String?
    var data : CartDataResponse?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        errors <- map["errors"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

class CartDataResponse: Mappable {
    var couponId : String?
    var deliveryCharges : Double?
    var discount : Double?
    var discountPercentage: Int?
    var payable: Double?
    var restaurantId: String?
    var roundOff: Int?
    var subtotal: Double?
    var tax: Double?
    var total: Double?
    
    var cartItems: [CartItemData]?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        couponId <- map["couponId"]
        deliveryCharges <- map["deliveryCharges"]
        discount <- map["discount"]
        discountPercentage <- map["discountPercentage"]
        payable <- map["payable"]
        restaurantId <- map["restaurantId"]
        roundOff <- map["roundOff"]
        subtotal <- map["subtotal"]
        tax <- map["tax"]
        total <- map["total"]
        
        cartItems <- map["cartItems"]
        
    }
    
}

