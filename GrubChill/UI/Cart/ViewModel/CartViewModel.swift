//
//  CartViewModel.swift
//  GrubChill
//
//  Created by mac on 09/01/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import ProgressHUD

class CartViewModel {
    weak var cartView: CartListVc?
    let cardNoPublishObject = BehaviorRelay<String>(value: "")
    let monthPublichObject = BehaviorRelay<String>(value: "")
    let yearPublishObject = BehaviorRelay<String>(value: "")
    let cvvPublichObject = BehaviorRelay<String>(value: "")
    let zipcodePublichObject = BehaviorRelay<String>(value: "")
    
    let userNamePublichObject = BehaviorRelay<String>(value: "")
    let phoneNoPublichObject = BehaviorRelay<String>(value: "")
    let emailPublichObject = BehaviorRelay<String>(value: "")

    
    let cardNoValue = BehaviorRelay<Bool>(value: false)
    let monthValue = BehaviorRelay<Bool>(value: false)
    let yearValue = BehaviorRelay<Bool>(value: false)
    let cvvValue = BehaviorRelay<Bool>(value: false)
    let zipcodeValue = BehaviorRelay<Bool>(value: false)
    
    let userNameValue = BehaviorRelay<Bool>(value: false)
    let emailValue = BehaviorRelay<Bool>(value: false)
    let phoneNoValue = BehaviorRelay<Bool>(value: false)
    
    var checkoutResponse = CheckOutResponseDTO()

    
    func checkoutAPI(){
        
        cartView?.cartMenu = (cartView?.databaseHandler.getCartModelList())!
        
        dump(cartView?.cartMenu)
        
        if cartView?.cartMenu.cartItem?.count ?? 0 > 0 {
            ProgressHUD.show("Please Wait...")
            let urlStr = Constant.Base_URL + Constant.CHECKOUT
            
            var cartItems = [[String: Any]]()
            for index in cartView!.cartMenu.cartItem! {
                var cartSingle = [String: Any]()
                cartSingle["businessid"] = index.businessid
                cartSingle["pic"] = index.pic
                cartSingle["description"] = index.description
                cartSingle["itemid"] = index.itemid
                cartSingle["price"] = index.price
                cartSingle["isactive"] = index.isactive
                cartSingle["qty"] = index.qty
                cartSingle["item"] = index.item
                
                cartItems.append(cartSingle)
            }
            
            print("cartItems --> \(cartItems)")
            
            var cardinfo = [String:Any]()
           
            cardinfo["card_number"] = cardNoPublishObject.value
            cardinfo["expiry_month"] = monthPublichObject.value
            cardinfo["expiry_year"] = yearPublishObject.value
            cardinfo["cvv"] = cvvPublichObject.value
            cardinfo["zipcode_card"] =  zipcodePublichObject.value

            var userinfo = [String:Any]()
            
            userinfo["email"] = cartView?.emailID.text
            userinfo["phonenumber"] = cartView?.phoneNo.text
            userinfo["username"] = cartView?.userName.text
            userinfo["role"] = "user"
            
            var checkout = [String:Any]()
            
            checkout["cartItems"] = cartItems
            
            let body = [
                "cardinfo" : cardinfo,
                "userinfo" : userinfo,
                "checkoutItems" : checkout,
                "couponCode":  cartView?.cartMenu.couponCode ?? "",
                "deliveryAddress": "",
                "delivery_method": cartView?.delivery_type ?? "",
                "payment_type": "card",
                "restaurantId": "\(cartView?.cartMenu.restaurantId ?? "")",
                "token": "",
                "trans_address": ""
            ] as [String:Any]
        
//            let body = [
//                "restaurantId" : cartView?.cartMenu.restaurantId ?? 0,
//                "address_id" : cartView?.cartMenu.address_id ?? "",
//                "couponCode" : cartView?.cartMenu.couponCode ?? "",
//                "delivery_method" : "Delivery",
//                "checkoutItems" : cartItems
//            ] as Parameters
            
            print("body --> \(body)")
            
            AF.request(urlStr, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { response in
                let statusCode = response.response?.statusCode
                print("\(statusCode ?? 0)")
                switch response.result {
                case .success (let JSON):
                    ProgressHUD.dismiss()
                    self.checkoutResponse = CheckOutResponseDTO()
                    self.checkoutResponse = CheckOutResponseDTO(JSON: JSON as! [String: Any]) ?? CheckOutResponseDTO()
                    
                    print("Checkout API Response JSON --> \(JSON)")
                    if statusCode == 200 {
                        
                        self.cartView?.showToast(message: " Order have been successfully placed" , color: UIColor.green)
                            
                        self.successfully()
                                            
                    }else{
                        
                        
                        self.cartView?.showToast(message: self.checkoutResponse.errors  ?? "Please try again" , color: UIColor.red)

                    }
                    break
                case .failure(let error):
                    print("error--> \(error)")
                    break
                }
            }
        }

    }
    
    func successfully(){
        
        self.cartView?.databaseHandler.deleteAllItems()
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
            self.cartView?.navigationController?.popViewController(animated: true)
        }
        
    }

}


import Foundation
import UIKit
import CommonCrypto

extension String {
    
    func isValidCardNo() -> Bool{
        if self.count != 16 {
            return false
        }else {
            let phNoRegEx = "^[0-9]+$"
            let phNoTest = NSPredicate(format:"SELF MATCHES %@", phNoRegEx)
            if !phNoTest.evaluate(with: self){
                return false
            }
        }
        return true
    }
    
    func isValidMonth() -> Bool{
        if self.count != 2 {
            return false
        }else {
            let phNoRegEx = "^[0-9]+$"
            let phNoTest = NSPredicate(format:"SELF MATCHES %@", phNoRegEx)
            if !phNoTest.evaluate(with: self){
                return false
            }
            else if(Int(self) ?? 0 < 12){
                return false
            }
        }
        return true
    }
    
    func isValidYear() -> Bool{
        if self.count != 2 {
            return false
        }else {
            let phNoRegEx = "^[0-9]+$"
            let phNoTest = NSPredicate(format:"SELF MATCHES %@", phNoRegEx)
            if !phNoTest.evaluate(with: self){
                return false
            }
            
        }
        return true
    }
    
    func isValidCvv() -> Bool{
        if self.count != 3 {
            return false
        }else {
            let phNoRegEx = "^[0-9]+$"
            let phNoTest = NSPredicate(format:"SELF MATCHES %@", phNoRegEx)
            if !phNoTest.evaluate(with: self){
                return false
            }
                   }
        return true
    }
    
    func isValidText() -> Bool{
        if self == "" {
            print("sleelelelelelelelel")
            return false
        }
        return true
    }
    
}
