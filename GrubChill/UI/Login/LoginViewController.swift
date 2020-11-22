//
//  ViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loginView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 50.0)
        super.viewWillAppear(animated)
    }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
