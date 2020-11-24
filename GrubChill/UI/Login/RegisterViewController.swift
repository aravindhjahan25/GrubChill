//
//  RegisterViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit
import Alamofire
import ProgressHUD

class RegisterViewController: BaseController {
    
    @IBOutlet weak var registerView : UIView!
    
    @IBOutlet weak var phoneNoTextFeild : UITextField!
    @IBOutlet weak var userNameTextFeild : UITextField!
    @IBOutlet weak var emailIDTextFeild : UITextField!
    @IBOutlet weak var passwordTextFeild : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {

        registerView.clipsToBounds = true
        registerView.layer.cornerRadius = 40
        registerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        super.viewWillAppear(animated)
    }

    @IBAction func registerBTN(_ sender : UIButton) {
        if phoneNoTextFeild.text != "" &&
            userNameTextFeild.text != "" &&
            emailIDTextFeild.text != "" &&
            passwordTextFeild.text != "" {
            
            ProgressHUD.show("Please Wait...")
            
            let urlStr = Constant.Base_URL + Constant.REGISTER
            let body = [
                "phonenumber": phoneNoTextFeild.text ?? "",
                "username": userNameTextFeild.text ?? "",
                "email": emailIDTextFeild.text ?? "",
                "password": passwordTextFeild.text ?? "",
                "role": Constant.ROLE_USER,
                "createdby": Constant.CREATED_BY,
                "status": Constant.STATUS_ACTIVE
            ] as Parameters
            
            registerAPI_Call(strUrl: urlStr, params: body)
            
        }else{
            print("Something Wrong..")
        }
    }

    func registerAPI_Call(strUrl: String, params: Parameters){
       
        AF.request(strUrl, method: .post, parameters: params,encoding: JSONEncoding.default).responseJSON {
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
                            self.navigationController?.popViewController(animated: true)
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
                        self.registerAPI_Call(strUrl: strUrl, params: params)
                    }else{
                       
                    }
                    break
            }
        }
        
    }
}
