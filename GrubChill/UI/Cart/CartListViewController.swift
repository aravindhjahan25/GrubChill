//
//  CartListViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit
import ProgressHUD
import Alamofire

class CartListViewController: BaseController ,UITableViewDataSource {
                                //, UITableViewDelegate ,UICollectionViewDelegate,UICollectionViewDataSource {
    
     @IBOutlet weak var cartTableView : UITableView!
//    @IBOutlet weak var AddressCollection : UICollectionView!
//
//    var restrauntDetails: RestrauntList?
//    var restrauntMenu = RestrauntMenuDTO()
//
//    var addressArray = [String]()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var billingheightConstraint: NSLayoutConstraint!

    @IBOutlet weak var pickUpSelectedImage: UIImageView!
    @IBOutlet weak var deliverySelectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billingView.isHidden = true
        billingheightConstraint.constant = 0
        
        pickUpSelectedImage.image = UIImage(named: "check-2.png")
        deliverySelectedImage.image = UIImage(named: "check.png")
        
//        cartTableView?.register(SubTotalTableViewCell.nib, forCellReuseIdentifier: SubTotalTableViewCell.identifier)
//        
//        cartTableView?.register(MenuItemsTableViewCell.nib, forCellReuseIdentifier: MenuItemsTableViewCell.identifier)
        
//        addressArray = ["Address 1","Address 2","Address 3","Address 4","Address 5","Address 6","Address 7"]
//
//        self.getMenuList()
    }
    
    
//    func getMenuList(){
//        let urlString = Constant.Base_URL + Constant.DASHBOARD_ENDPOINT + "/1202010260458"
//        ProgressHUD.show("Please Wait...")
//
//        AF.request(urlString, method: .get, encoding: JSONEncoding.default).responseJSON {
//            response in
//            let statusCode = response.response?.statusCode
//            print("\(statusCode ?? 0)")
//            switch response.result {
//                case .success (let JSON):
//                    if statusCode == 200 {
//                        print("JSON--> \(JSON)")
//                        self.restrauntMenu = RestrauntMenuDTO(JSON: JSON as! [String: Any])!
//
////                        self.showEmptyView.isHidden = true
//                        self.cartTableView.dataSource = self
//                        self.cartTableView.delegate = self
//
//                        ProgressHUD.dismiss()
//                        self.cartTableView.reloadData()
//
//                        self.cartTableView.layoutIfNeeded()
//
////                        self.cartTableView.frame.size = self.cartTableView.contentSize
//
////                        self.cartTableView.isScrollEnabled=false
//                        self.cartTableView.rowHeight = UITableView.automaticDimension
//
////                        DispatchQueue.main.sync {
//
//                                //This code will run in the main thread:
//                                var  frame:CGRect = self.cartTableView.frame;
//                                frame.size.height = self.cartTableView.contentSize.height;
//                                self.cartTableView.frame = frame;
////                            }
//                    }
//
//                    break
//                case .failure(let error):
//                    if error._code == NSURLErrorTimedOut {
//                        print("timeOut")
//                        self.getMenuList()
//                    }else{
//
//                    }
//                    break
//            }
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//    }

    
    
//    func numberOfSections(in tableView: UITableView) -> Int{
//        return self.restrauntMenu.data?.menu?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 35
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = Bundle.main.loadNibNamed("RestrauntDetailHeaderCell", owner: self, options: nil)?.first as! RestrauntDetailHeaderCell
////        print("\(self.restrauntMenu.data?.menu?[section].category)")
//        headerView.configure(str: self.restrauntMenu.data?.menu?[section].category ?? "")
//        return headerView
//    }
//
//
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath as IndexPath) as! CartTableViewCell
        cell.configure()
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.addressArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCollectionViewCell", for: indexPath as IndexPath) as! AddressCollectionViewCell
////        cell.configure(restrauntSingle: self.restrauntList.data![indexPath.row])
//
//        cell.AddressLab.text = self.addressArray[indexPath.row]
//
//        return cell
//    }
  
    @IBAction func pickupBTN(_ sender: UIButton){
        billingView.isHidden = true
        billingheightConstraint.constant = 0
        
        pickUpSelectedImage.image = UIImage(named: "check-2.png")
        deliverySelectedImage.image = UIImage(named: "check.png")

    }
    
    @IBAction func deliveryBtn(_ sender: UIButton){
        billingheightConstraint.constant = 205
        billingView.isHidden = false
        
        pickUpSelectedImage.image = UIImage(named: "check.png")
        deliverySelectedImage.image = UIImage(named: "check-2.png")

    }
}
