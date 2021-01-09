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
            ProgressHUD.show("Please Wait...")
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
    
    @IBAction func homeBtn(_ sender: UIButton){
        let dashBoard = UIStoryboard.named.main.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(dashBoard, animated: true)
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
                            self.sharedPref.createLoginSession(
                                _id: (loginDTO?.data?._id ?? ""),
                                phonenumber: (loginDTO?.data?.phonenumber ?? ""),
                                username: (loginDTO?.data?.username ?? ""),
                                email: (loginDTO?.data?.email ?? ""),
                                role: (loginDTO?.data?.role ?? ""),
                                status: (loginDTO?.data?.status ?? ""),
                                isVerified: (loginDTO?.data?.isVerified ?? false),
                                stripe_id: (loginDTO?.data?.stripe_id ?? ""),
                                business_id: (loginDTO?.data?.business_id ?? ""))
                            
                            ProgressHUD.dismiss()
                            let dashBoard = UIStoryboard.named.main.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                            self.navigationController?.pushViewController(dashBoard, animated: true)
                        }else{
                            ProgressHUD.dismiss()
                            print("Failed")
                        }
                    }else{
                        ProgressHUD.dismiss()
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

