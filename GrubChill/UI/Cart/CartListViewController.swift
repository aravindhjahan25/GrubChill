//
//  CartListViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit
import ProgressHUD
import Alamofire

class CartListViewController: BaseController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cartTableView : UITableView!
    
    
    var restrauntDetails: RestrauntList?
    var restrauntMenu = RestrauntMenuDTO()


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cartTableView?.register(SubTotalTableViewCell.nib, forCellReuseIdentifier: SubTotalTableViewCell.identifier)
//        
//        cartTableView?.register(MenuItemsTableViewCell.nib, forCellReuseIdentifier: MenuItemsTableViewCell.identifier)

        self.getMenuList()
    }
    
    
    func getMenuList(){
        let urlString = Constant.Base_URL + Constant.DASHBOARD_ENDPOINT + "/1202010260458"  
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
                        
//                        self.showEmptyView.isHidden = true
                        self.cartTableView.dataSource = self
                        self.cartTableView.delegate = self
                        
                        ProgressHUD.dismiss()
                        self.cartTableView.reloadData()
                        
                        self.cartTableView.layoutIfNeeded()
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
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.restrauntMenu.data?.menu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("RestrauntDetailHeaderCell", owner: self, options: nil)?.first as! RestrauntDetailHeaderCell
//        print("\(self.restrauntMenu.data?.menu?[section].category)")
        headerView.configure(str: self.restrauntMenu.data?.menu?[section].category ?? "")
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restrauntMenu.data?.menu?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrauntMenusTableViewCell", for: indexPath as IndexPath) as! RestrauntMenusTableViewCell
        cell.configure(itemSingle: self.restrauntMenu.data!.menu![indexPath.section].items![indexPath.row])
        return cell
    }

}
