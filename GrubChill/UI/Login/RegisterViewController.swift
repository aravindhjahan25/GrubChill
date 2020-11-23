//
//  RegisterViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit

class RegisterViewController: BaseController {
    
    @IBOutlet weak var registerView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {

        registerView.clipsToBounds = true
        registerView.layer.cornerRadius = 40
        registerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        super.viewWillAppear(animated)
    }


}
