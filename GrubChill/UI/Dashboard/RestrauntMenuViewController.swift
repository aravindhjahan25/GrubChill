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
    var databaseHandler = DatabaseHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentDeliveryType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showEmptyView.isHidden = false
        getMenuList()
        super.viewWillAppear(animated)
    }
    
    func getMenuList(){
        let urlString = Constant.Base_URL + Constant.DASHBOARD_ENDPOINT + "/" + (self.restrauntDetails?.businessid)!
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
    
    func presentDeliveryType()  {
        let detailMenuVC = UIStoryboard.named.dashboard.instantiateViewController(identifier: "DeliveryTypeViewController") as! DeliveryTypeViewController
        detailMenuVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(detailMenuVC, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.restrauntMenu.data?.menu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("RestrauntDetailHeaderCell", owner: self, options: nil)?.first as! RestrauntDetailHeaderCell
        headerView.configure(str: self.restrauntMenu.data?.menu?[section].category ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restrauntMenu.data?.menu?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrauntMenusTableViewCell", for: indexPath as IndexPath) as! RestrauntMenusTableViewCell
        cell.configure(itemSingle: self.restrauntMenu.data!.menu![indexPath.section].items![indexPath.row])
        
        cell.add.tag = (indexPath.section*100)+indexPath.row
        cell.addBtn.tag = (indexPath.section*100)+indexPath.row
        cell.subBtn.tag = (indexPath.section*100)+indexPath.row

        cell.add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        cell.addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        cell.subBtn.addTarget(self, action: #selector(subAction), for: .touchUpInside)

        
        return cell
    }
    
    @objc func addAction(sender: UIButton) -> Void{
        
        let section = sender.tag / 100
        let row = sender.tag % 100
        
        print("\(section)")
        print("\(row)")
        
        self.restrauntMenu.data!.menu![section].items![row].quantity! += 1
        
        let detailMenuVC = UIStoryboard.named.dashboard.instantiateViewController(identifier: "OptionMenuViewController") as! OptionMenuViewController
        detailMenuVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(detailMenuVC, animated: true)
        
        self.menuListTable.reloadData()
   }

    @objc func subAction(sender: UIButton) -> Void{
        
        let section = sender.tag / 100
        let row = sender.tag % 100
        
        print("\(section)")
        print("\(row)")
        
        
        self.restrauntMenu.data!.menu![section].items![row].quantity! -= 1
        
        
        var Menudata : Itemdata
        
        Menudata = self.restrauntMenu.data!.menu![section].items![row]
        
//        databaseHandler.insertCartModel(itemid: "\(Menudata.itemid)", item: Menudata.item, price: Menudata.price, orderid: "", pic: Menudata.pic, quantity: Menudata.quantity, description: Menudata.description, isFavourite: true, isActive: true, optiongroupid: "", optiongroupname: "", optionname: "", optionid: "", optionprice: "")
        self.menuListTable.reloadData()
   }
}
