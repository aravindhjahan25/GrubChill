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

    override func viewWillAppear(_ animated: Bool) {
        
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
