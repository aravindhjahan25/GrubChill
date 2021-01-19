//
//  LoginPreference.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import Foundation

struct LoginPreference{
    
    enum Keys: String, CaseIterable {
        case _id
        case phonenumber
        case username
        case email
        case role
        case status
        case isVerified
        case stripe_id
        case business_id
    }
    
    func createLoginSession(_id : String,
                            phonenumber: String,
                            username : String,
                            email : String,
                            role : String,
                            status : String,
                            isVerified : Bool,
                            stripe_id : String,
                            business_id : String,
                            address : [[String:Any]] ){
        UserDefaults.standard.set(_id, forKey: "_id")
        UserDefaults.standard.set(phonenumber, forKey: "phonenumber")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(role, forKey: "role")
        UserDefaults.standard.set(status, forKey: "status")
        UserDefaults.standard.set(isVerified, forKey: "isVerified")
        UserDefaults.standard.set(stripe_id, forKey: "stripe_id")
        UserDefaults.standard.set(business_id, forKey: "business_id")
        UserDefaults.standard.set(address, forKey: "address")
        
//        UserDefaults.standard.set
    }

    func clearUserDefaults(){
        Keys.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
}
