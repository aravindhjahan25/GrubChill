//
//  MyProfileViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 24/11/20.
//

import UIKit

class MyProfileViewController: BaseController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var addressTable: UITableView!

    var addressArray : [[String:Any]]!
    var addressString : String!

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
        
        
        
        addressArray = (UserDefaults.standard.object(forKey: "address") as! [[String:Any]])
        
        addressTable.dataSource = self
        addressTable.delegate = self
        
        addressTable.reloadData()
        
        print("addresssss--------->\(addressArray)")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath as IndexPath) as! AddressTableViewCell
        cell.configure(Addressdata: addressArray[indexPath.row])
        return cell
    }
    
}
