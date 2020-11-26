//
//  RestrauntsDTO.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 25/11/20.
//

import Foundation
import ObjectMapper

class RestrauntsDTO : Mappable {
    
    var status : String?
    var message : String?
    var errors : String?
    var data : [RestrauntList]?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        errors <- map["errors"]
        data <- map["data"]
    }
    
}

class RestrauntList: Mappable {
    var businessid : String?
    var name : String?
    var phone : String?
    var categoryone: String?
    var categorytwo: String?
    var zipCode: String?
    var subtext: String?
    var logo: String?
    var email: String?
    var address: String?
    var city: String?
    var state: String?
    var country: String?

    init(){ }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        businessid <- map["businessid"]
        name <- map["name"]
        phone <- map["phone"]
        categoryone <- map["categoryone"]
        categorytwo <- map["categorytwo"]
        zipCode <- map["zipCode"]
        subtext <- map["subtext"]
        logo <- map["logo"]
        email <- map["email"]
        address <- map["address"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
    }
    
}
