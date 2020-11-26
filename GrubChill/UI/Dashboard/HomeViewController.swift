//
//  HomeViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import UIKit
import Alamofire
import ProgressHUD

class HomeViewController: BaseController,
                          UICollectionViewDataSource,
                          UITableViewDataSource,
                          UITableViewDelegate{
    
    @IBOutlet weak var topPickUp: UICollectionView!
    @IBOutlet weak var restrauntTable: UITableView!

    
    var restrauntList = RestrauntsDTO()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getRestrauntListAPI_Call()
        
        super.viewWillAppear(animated)
    }
    
    func getRestrauntListAPI_Call(){
        let urlString = Constant.Base_URL + Constant.DASHBOARD_ENDPOINT
        ProgressHUD.show("Please Wait...")
        AF.request(urlString, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in
            let statusCode = response.response?.statusCode
            print("\(statusCode ?? 0)")
            switch response.result {
                case .success (let JSON):
                    print(JSON)
                    if statusCode == 200 {
                        self.restrauntList = RestrauntsDTO(JSON: JSON as! [String : Any])!
                        self.topPickUp.dataSource = self
                        self.restrauntTable.dataSource = self
                        ProgressHUD.dismiss()
                        self.topPickUp.reloadData()
                        self.restrauntTable.reloadData()
                    }else{
                        print("Status Code Failed")
                    }
                    
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("timeOut")
                        self.getRestrauntListAPI_Call()
                    }else{
                       
                    }
                    break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.restrauntList.data!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPickCollectionViewCell", for: indexPath as IndexPath) as! TopPickCollectionViewCell
        cell.configure(restrauntSingle: self.restrauntList.data![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restrauntList.data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath as IndexPath) as! DashboardTableViewCell
        cell.configure(restrauntSingle: self.restrauntList.data![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMenuVC = UIStoryboard.named.dashboard.instantiateViewController(identifier: "RestrauntMenuViewController") as! RestrauntMenuViewController
        detailMenuVC.restrauntDetails = self.restrauntList.data![indexPath.row]
        self.navigationController?.pushViewController(detailMenuVC, animated: true)
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
    func cardDesign(shadowPath : Bool, radius : CGFloat) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        if shadowPath{
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
            layer.shadowPath = shadowPath.cgPath
        }
        layer.shadowOpacity = 0.3
    }
}
