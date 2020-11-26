//
//  SupportViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 24/11/20.
//

import UIKit

class SupportViewController: BaseController {

    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var phoneNO: UILabel!
    @IBOutlet weak var address: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        emailID.text = Constant.contactEmail
        address.text = Constant.contactAddress
        
        let attributedString = NSMutableAttributedString.init(string: Constant.contactPhoneNo)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                    NSRange.init(location: 0, length: attributedString.length));
        phoneNO.attributedText = attributedString
        
        super.viewWillAppear(animated)
    }

}
