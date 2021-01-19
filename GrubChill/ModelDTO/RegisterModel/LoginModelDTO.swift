//
//  LoginModelDTO.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import Foundation
import ObjectMapper

class LoginModelDTO : Mappable {
    
    var status : String?
    var message : String?
    var errors : String?
    
    var data : data?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        errors <- map["errors"]
        data <- map["data"]
    }
    
}

class data: Mappable {
    var _id : String?
    var phonenumber : String?
    var username : String?
    var email: String?
    var role: String?
    var createdby: String?
    var status: String?
    var isVerified: Bool?
    var updated_at: String?
    var created_at: String?
    var stripe_id: String?
    var business_id: String?
    var user_address : userAddressDTO?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        _id <- map["_id"]
        phonenumber <- map["phonenumber"]
        username <- map["username"]
        email <- map["email"]
        role <- map["role"]
        createdby <- map["createdby"]
        status <- map["status"]
        isVerified <- map["isVerified"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        stripe_id <- map["stripe_id"]
        business_id <- map["business_id"]
        user_address <- map["user_address"]
    }
    
}

class userAddressDTO: Mappable {
    var _id : String?
    var email: String?
    var updated_at: String?
    var created_at: String?
    var address : [AddressDTO]?
    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        _id <- map["_id"]
        email <- map["email"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        address <- map["address"]
    }
}

class AddressDTO: Mappable {
    var address1 : String?
    var address2 : String?
    var city: String?
    var state: String?
    var zipcode: String?
    var address_type: String?

    
    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        address1 <- map["address1"]
        address2 <- map["address2"]
        city <- map["city"]
        state <- map["state"]
        zipcode <- map["zipcode"]
        address_type <- map["address_type"]

    }
    
}

