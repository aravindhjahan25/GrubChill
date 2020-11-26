//
//  BaseController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import Foundation
import UIKit

class BaseController : UIViewController {
    
    @IBOutlet weak var showEmptyView: UIView!
    
    var sharedPref = LoginPreference()
    
    @IBAction func popBack(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtn(_ sender : UIButton){
        let cartVC = UIStoryboard.named.cart.instantiateViewController(identifier: "CartListViewController") as! CartListViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func myProfileBtn(_ sender : UIButton){
        let cartVC = UIStoryboard.named.profile.instantiateViewController(identifier: "MyProfileViewController") as! MyProfileViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func supportBtn(_ sender : UIButton){
        let cartVC = UIStoryboard.named.sideMenu.instantiateViewController(identifier: "SupportViewController") as! SupportViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @IBAction func logoutBtn(_ sender : UIButton){
        sharedPref.clearUserDefaults()
        let cartVC = UIStoryboard.named.main.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
