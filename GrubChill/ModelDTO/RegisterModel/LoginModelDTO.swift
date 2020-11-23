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
    }
    
}
