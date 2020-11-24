//
//  SideMenuViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import UIKit

class SideMenuViewController: BaseController {
    
    @IBOutlet weak var skipLogin: UIView!
    @IBOutlet weak var loggedIn: UIView!
    
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var phoneNO : UILabel!

    override func viewWillAppear(_ animated: Bool) {
        if isKeyPresentInUserDefaults(key: "_id"){
            let uName = UserDefaults.standard.string(forKey: "username") ?? ""
            if uName != "" {
                skipLogin.isHidden = true
                loggedIn.isHidden = false
                print("uName --> \(uName)")
                userName.text = uName
                phoneNO.text = UserDefaults.standard.string(forKey: "phonenumber") ?? ""
            }else{
                loggedIn.isHidden = true
                skipLogin.isHidden = false
            }
            
        }else{
            loggedIn.isHidden = true
            skipLogin.isHidden = false
        }
        
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login(_ sender: UIButton){
        let loginVC = UIStoryboard.named.main.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func termsCondition(_ sender : UIButton){
        let termsCondition = UIStoryboard.named.sideMenu.instantiateViewController(identifier: "TermsandConditionViewController") as! TermsandConditionViewController
        self.navigationController?.pushViewController(termsCondition, animated: true)
    }

}
