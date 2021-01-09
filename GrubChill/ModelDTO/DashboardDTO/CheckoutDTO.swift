//
//  CheckoutDTO.swift
//  GrubChill
//
//  Created by mac on 07/01/21.
//

import Foundation
import ObjectMapper

class CheckoutDTO : Mappable {
    var couponCode : String?
    var deliveryAddress : String?
    var delivery_method : String?
    var payment_type : String?
    var token : String?
    var trans_address : String?
    var userinfo : userinfoDTO?
    var cardinfo : cardinfoDTO?
    var checkoutItems : CartDataResponse?
    

    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        couponCode <- map["couponCode"]
        deliveryAddress <- map["deliveryAddress"]
        delivery_method <- map["delivery_method"]
        payment_type <- map["payment_type"]
        token <- map["token"]
        trans_address <- map["token"]
        userinfo <- map["userinfo"]
        cardinfo <- map["cardinfo"]
        checkoutItems <- map["checkoutItems"]
        
    }
    
}

class cardinfoDTO :Mappable{
    var card_number : String?
    var cvv : String?
    var expiry_month : String?
    var expiry_year : String?
    var zipcode_card : String?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        card_number <- map["card_number"]
        cvv <- map["errors"]
        expiry_month <- map["message"]
        expiry_year <- map["expiry_year"]
        zipcode_card <- map["zipcode_card"]
    }

}


class userinfoDTO :Mappable{
    var email : String?
    var phonenumber : String?
    var role : String?
    var username : String?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        email <- map["email"]
        phonenumber <- map["phonenumber"]
        role <- map["role"]
        username <- map["username"]
    }

}
