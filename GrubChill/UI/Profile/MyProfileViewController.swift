//
//  MyProfileViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 24/11/20.
//

import UIKit

class MyProfileViewController: BaseController {
    
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var userName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.userinfofill()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        super.viewWillAppear(animated)
    }
    
    
    func userinfofill(){
        userName.text = UserDefaults.standard.string(forKey: "username") ?? ""
        emailID.text = UserDefaults.standard.string(forKey: "email") ?? ""
        phoneNo.text = UserDefaults.standard.string(forKey: "phonenumber") ?? ""
    }

}
