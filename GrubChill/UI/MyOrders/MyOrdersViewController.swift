//
//  MyOrdersViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 04/12/20.
//

import UIKit
import ProgressHUD
import Alamofire

class MyOrdersViewController: BaseController ,UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var OrderTable: UITableView!

    var Myorder = MyOrderDTO()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMenuList()
    }
    
    
    func getMenuList(){
        let email: String = UserDefaults.standard.string(forKey: "email")  ?? "srinivasan@gmail.com"
        let urlString = Constant.Base_URL + Constant.My_Orders + "?email=" +  email
        ProgressHUD.show("Please Wait...")
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in
            let statusCode = response.response?.statusCode
            print("\(statusCode ?? 0)")
            switch response.result {
                case .success (let JSON):
                    if statusCode == 200 {
                        print("JSON--> \(JSON)")
                        self.Myorder = MyOrderDTO(JSON: JSON as! [String: Any])!
                        
                        self.OrderTable.dataSource = self
                        self.OrderTable.delegate = self
//                        self.showEmptyView.isHidden = true
                        
                        ProgressHUD.dismiss()
                        self.OrderTable.reloadData()
                        
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
        return self.Myorder.data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // get a reference to our storyboard cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath as IndexPath) as! MyOrderTableViewCell
        
        cell.configure(itemSingle: (self.Myorder.data?[indexPath.row])! )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.Myorder.data?[indexPath.row].items ?? "nooo")
        
        if((self.Myorder.data?[indexPath.row].items!.count)! >= 1){
            let orderList = UIStoryboard.named.order.instantiateViewController(identifier: "OrderListPopupViewController") as! OrderListPopupViewController
            orderList.itemsMenu = (self.Myorder.data?[indexPath.row].items)!
            orderList.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.present(orderList, animated: true)
        }
    }


}
