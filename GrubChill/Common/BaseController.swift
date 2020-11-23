//
//  BaseController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import Foundation
import UIKit

class BaseController : UIViewController {
    
    
    @IBAction func popBack(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtn(_ sender : UIButton){
        let cartVC = UIStoryboard.named.cart.instantiateViewController(identifier: "CartListViewController") as! CartListViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
}
