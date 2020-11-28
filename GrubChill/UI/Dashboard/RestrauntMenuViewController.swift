//
//  RestrauntMenuViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 26/11/20.
//

import UIKit
import Alamofire
import ProgressHUD

class RestrauntMenuViewController: BaseController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var restrauntName :UILabel!
    @IBOutlet weak var address :UILabel!
    
    @IBOutlet weak var menuListTable: UITableView!

    var restrauntDetails: RestrauntList?
    var restrauntMenu = RestrauntMenuDTO()

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
                        self.restrauntName.text = self.restrauntDetails?.name ?? ""
                        self.address.text =
                            "\(self.restrauntDetails!.address ?? ""),\(self.restrauntDetails!.city ?? ""),\n\(self.restrauntDetails!.state ?? ""),\n\(self.restrauntDetails!.country ?? "") - \(self.restrauntDetails!.zipCode ?? "")"
                        
                        self.menuListTable.dataSource = self
                        self.menuListTable.delegate = self
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
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.restrauntMenu.data!.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("RestrauntDetailHeaderCell", owner: self, options: nil)?.first as! RestrauntDetailHeaderCell
        headerView.configure(str: self.restrauntMenu.data![section].category ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restrauntMenu.data![section].items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrauntMenusTableViewCell", for: indexPath as IndexPath) as! RestrauntMenusTableViewCell
        cell.configure(itemSingle: self.restrauntMenu.data![indexPath.section].items![indexPath.row])
        return cell
    }

}
