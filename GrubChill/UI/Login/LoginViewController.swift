//
//  ViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import UIKit
import Alamofire
import ProgressHUD

class LoginViewController: BaseController {
    
    @IBOutlet weak var loginView : UIView!
    
    @IBOutlet weak var emailIDTextFeild : UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loginView.clipsToBounds = true
        loginView.layer.cornerRadius = 40
        loginView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        super.viewWillAppear(animated)
    }
    
    @IBAction func loginBtn(_ sender : UIButton){
        if emailIDTextFeild.text != "" && passwordTextFeild.text != ""{
            ProgressHUD.show("Please Wait")
            let URL = Constant.Base_URL + Constant.LOGIN
            let body = [
                "email": emailIDTextFeild.text ?? "" ,
                "password": passwordTextFeild.text ?? ""
            ] as Parameters
            
            loginAPI_Call(urlString: URL, params: body)
        }
    }
    
    @IBAction func registerBtn(_ sender: UIButton){
        let registerVC = UIStoryboard.named.main.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    func loginAPI_Call(urlString: String, params: Parameters) {
        
        AF.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default).responseJSON {
            response in
            let statusCode = response.response?.statusCode
            print("\(statusCode ?? 0)")
            switch response.result {
                case .success (let JSON):
                    print(JSON)
                    if statusCode == 200 {
                        let loginDTO = LoginModelDTO(JSON: JSON as! [String : Any])
                        if loginDTO?.status == "Success" {
                            ProgressHUD.dismiss()
                            let dashBoard = UIStoryboard.named.dashboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                            self.navigationController?.pushViewController(dashBoard, animated: true)
                        }else{
                            print("Failed")
                        }
                    }else{
                        print("Status Code Failed")
                    }
                    
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("timeOut")
                        self.loginAPI_Call(urlString: urlString, params: params)
                    }else{
                       
                    }
                    break
            }
        }
        
    }
}

extension UIView {
    func roundCornersLeft(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCornersRight(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
  }
}

