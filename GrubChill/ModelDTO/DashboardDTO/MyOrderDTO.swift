//
//  MyOrderDTO.swift
//  GrubChill
//
//  Created by Bharath Kumar on 05/12/20.
//

import Foundation
import ObjectMapper

class MyOrderDTO : Mappable {
    var status : String?
    var message : String?
    var errors : String?
    var data : [MyOrderData]?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        errors <- map["errors"]
        data <- map["data"]
    }
    
}

class MyOrderData : Mappable {
    
    var _id : String?
    var orderid : String?
    var businessid : String?
    var user_email : String?
    var payment_type : String?
    var delivery_method : String?
    var payment_status : String?
    var delivery_address : String?
    var subtotal : String?
    var discount : String?
    var discountPercentage : String?
    var couponId : String?
    var deliveryCharges : String?
    var netTotal : String?
    var tax : String?
    var total : Double?
    var roundOff : Double?
    var payable : Double?
    var created_at : String?
    var order_at : String?
    var order_created_at : String?

    
    var payment : paymentData?
    var items : [itemsData]?
    var userinfo : userinfoData?

    
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        _id <- map["_id"]
        orderid <- map["orderid"]
        businessid <- map["businessid"]
        user_email <- map["user_email"]
        payment_type <- map["payment_type"]
        delivery_method <- map["delivery_method"]
        payment_status <- map["payment_status"]
        delivery_address <- map["delivery_address"]
        subtotal <- map["subtotal"]
        discount <- map["discount"]
        discountPercentage <- map["discountPercentage"]
        couponId <- map["couponId"]
        deliveryCharges <- map["deliveryCharges"]
        netTotal <- map["netTotal"]
        tax <- map["tax"]
        total <- map["total"]
        roundOff <- map["roundOff"]
        payable <- map["payable"]
        created_at <- map["created_at"]
        order_at <- map["order_at"]
        order_created_at <- map["order_created_at"]
        
        
        payment <- map["payment"]
        items <- map["items"]
        userinfo <- map["userinfo"]

    }
    
}


class paymentData : Mappable {
    var method : String?
    var transaction_id : String?
    var amount_captured : String?
    var payment_type : String?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        method <- map["method"]
        transaction_id <- map["transaction_id"]
        amount_captured <- map["amount_captured"]
        payment_type <- map["payment_type"]
    }
}

class itemsData : Mappable {
    var businessid : String?
    var description : String?
    var isactive : String?
    var item : String?
    var itemid : String?
    var optiongroups : String?
    var price : String?
    var qty : String?
    var qty_price : String?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        businessid <- map["businessid"]
        description <- map["description"]
        isactive <- map["isactive"]
        item <- map["item"]
        itemid <- map["itemid"]
        optiongroups <- map["optiongroups"]
        price <- map["price"]
        qty <- map["qty"]
        qty_price <- map["qty_price"]
    }
    
}


class userinfoData : Mappable {
    var email : String?
    var phonenumber : String?
    var username : String?
    
    init(){ }
    required init?(map: Map) { }

    func mapping(map: Map) {
        email <- map["email"]
        phonenumber <- map["phonenumber"]
        username <- map["username"]
    }
}


