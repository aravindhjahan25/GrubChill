//
//  RestrauntMenuViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 26/11/20.
//

import UIKit
import Alamofire
import ProgressHUD

class RestrauntMenuViewController: BaseController, UITableViewDataSource {

    @IBOutlet weak var restrauntName :UILabel!
    @IBOutlet weak var address :UILabel!
    @IBOutlet weak var category :UILabel!
    
    @IBOutlet weak var menuListTable: UITableView!

    var restrauntDetails: RestrauntList?
    var restrauntMenu = RestrauntMenuDTO()
    var menuList = [MenuList]()
    var itemArrays = [ItemsArrayDTO]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showEmptyView.isHidden = false
        getMenuList()
        super.viewWillAppear(animated)
    }
    
    func getMenuList(){
        let urlString = Constant.Base_URL + Constant.MENUS_ENDPOINT + (self.restrauntDetails?.businessid)!
        ProgressHUD.show("Please Wait...")
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in
            let statusCode = response.response?.statusCode
            print("\(statusCode ?? 0)")
            switch response.result {
                case .success (let JSON):
                    if statusCode == 200 {
                        print("JSON--> \(JSON)")
                        self.restrauntMenu = RestrauntMenuDTO(JSON: JSON as! [String: Any])!
                        for index in self.restrauntMenu.data! {
                            self.menuList.append(index)
                            for itemIndex in index.items! {
                                self.itemArrays.append(itemIndex)
                            }
                        }
                        
                        self.restrauntName.text = self.restrauntDetails?.name ?? ""
                        self.address.text = "\(self.restrauntDetails!.address ?? ""), \(self.restrauntDetails!.city ?? ""), \(self.restrauntDetails!.state ?? ""), \(self.restrauntDetails!.country ?? "")"
                        
                        self.category.text = self.menuList[0].category ?? ""
                        self.menuListTable.dataSource = self
                        self.showEmptyView.isHidden = true
                        
                        ProgressHUD.dismiss()
                        self.menuListTable.reloadData()
                    }
                    
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("timeOut")
                        self.getMenuList()
                    }else{
                       
                    }
                    break
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrauntMenusTableViewCell", for: indexPath as IndexPath) as! RestrauntMenusTableViewCell
        cell.configure(itemSingle: self.itemArrays[indexPath.row])
        return cell
    }

}
