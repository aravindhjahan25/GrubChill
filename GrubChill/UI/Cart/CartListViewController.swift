//
//  CartListViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit
import ProgressHUD
import Alamofire

class CartListViewController: BaseController ,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
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
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var delevieryChargeLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var cardNo: UITextField!
    @IBOutlet weak var Expmonth: UITextField!
    @IBOutlet weak var Expyear: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var userName: UITextField!




    var cartMenu = CartDTO()
    
    var databaseHandler = DatabaseHandler()
    
    var cartResponse = CartResponseDTO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEmptyView.isHidden = false
        billingView.isHidden = true
        billingheightConstraint.constant = 0
        
        pickUpSelectedImage.image = UIImage(named: "check-2.png")
        deliverySelectedImage.image = UIImage(named: "check.png")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        
        
        self.cartAPICall()
    }
    func userinfofill(){
        userName.text = UserDefaults.standard.string(forKey: "username") ?? ""
        emailID.text = UserDefaults.standard.string(forKey: "email") ?? ""
        phoneNo.text = UserDefaults.standard.string(forKey: "phonenumber") ?? ""
    }
    
    func cartAPICall(){
        
        self.cartMenu = databaseHandler.getCartModelList()
        
        dump(self.cartMenu)
        
        if cartMenu.cartItem?.count ?? 0 > 0 {
            ProgressHUD.show("Please Wait...")
            let urlStr = Constant.Base_URL + Constant.CART
            
            var cartItems = [[String: Any]]()
            for index in cartMenu.cartItem! {
                var cartSingle = [String: Any]()
                cartSingle["businessid"] = index.businessid
                cartSingle["pic"] = index.pic
                cartSingle["description"] = index.description
                cartSingle["itemid"] = index.itemid
                cartSingle["price"] = index.price
                cartSingle["isactive"] = index.isactive
                cartSingle["qty"] = index.qty
                
                cartItems.append(cartSingle)
            }
            
            print("cartItems --> \(cartItems)")
            
            let body = [
                "restaurantId" : cartMenu.restaurantId ?? 0,
                "address_id" : cartMenu.address_id ?? "",
                "couponCode" : cartMenu.couponCode ?? "",
                "delivery_method" : "Delivery",
                "cartItems" : cartItems
            ] as Parameters
            print("body --> \(body)")
            
            AF.request(urlStr, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { response in
                let statusCode = response.response?.statusCode
                print("\(statusCode ?? 0)")
                switch response.result {
                case .success (let JSON):
                    ProgressHUD.dismiss()
                    print("Cart API Response JSON --> \(JSON)")
                    if statusCode == 200 {
                        self.cartResponse = CartResponseDTO()
                        self.cartResponse = CartResponseDTO(JSON: JSON as! [String: Any]) ?? CartResponseDTO()
                        
                        self.discountLabel.text = "$\(self.cartResponse.data?.discount ?? 0)"
                        self.delevieryChargeLabel.text = "$\(self.cartResponse.data?.deliveryCharges ?? 0)"
                        self.taxLabel.text = "$\(self.cartResponse.data?.tax ?? 0)"
                        self.subTotalLabel.text = "$\(self.cartResponse.data?.subtotal ?? 0)"
                        self.totalLabel.text = "$\(self.cartResponse.data?.total ?? 0)"
                        self.cartTableView.reloadData()
                        self.showEmptyView.isHidden = true

                    }else{
                        
                    }
                    break
                case .failure(let error):
                    print("error--> \(error)")
                    break
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartMenu.cartItem?.count ?? 0
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath as IndexPath) as! CartTableViewCell
        cell.configure(itemSingle: self.cartMenu.cartItem![indexPath.row])
        
        cell.addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        cell.SubButton.addTarget(self, action: #selector(subAction), for: .touchUpInside)
        return cell
    }
    
    @objc func addAction(sender: UIButton) -> Void{
        
        let section = sender.tag / 100
        let row = sender.tag % 100
        
        print("\(section)")
        print("\(row)")
                
        var Menudata = CartItemData()
        Menudata = self.cartMenu.cartItem![row]
        self.cartMenu.cartItem![row].qty! += 1
        

        let value : Bool = databaseHandler.insertCartModel(itemid: Menudata.itemid ?? "", item: Menudata.item ?? "", price: (Double(Menudata.qty!) * Menudata.price!) , pic: Menudata.pic ?? "", qty: self.cartMenu.cartItem![row].qty ?? 0, description: Menudata.description ?? "" , isactive: true , businessid: Menudata.businessid ?? "" ,restaurantId: self.cartMenu.restaurantId ?? "" , delivery_method: "delivery")
        
        print("value ----->> \(value)")
        print("value ----->> \(databaseHandler.getCartCount())")
        print("getCartModelList ----->> \(databaseHandler.getCartModelList())")
        dump(databaseHandler.getCartModelList())

        
        self.cartAPICall()

    }

    @objc func subAction(sender: UIButton) -> Void{
        
        let section = sender.tag / 100
        let row = sender.tag % 100
        
        print("\(section)")
        print("\(row)")
        
        var Menudata = CartItemData()
        Menudata = self.cartMenu.cartItem![row]
        self.cartMenu.cartItem![row].qty! -= 1

        let value : Bool = databaseHandler.insertCartModel(itemid: Menudata.itemid ?? "", item: Menudata.item ?? "", price: (Double(Menudata.qty!) * Menudata.price!) , pic: Menudata.pic ?? "", qty: self.cartMenu.cartItem![row].qty ?? 0, description: Menudata.description ?? "" , isactive: true , businessid: Menudata.businessid ?? "" ,restaurantId: self.cartMenu.restaurantId ?? "" , delivery_method: "delivery")
        
        
        
        if (self.cartMenu.cartItem![row].qty! == 0) {
            print(databaseHandler.deleteCartData(itemsID: Menudata.itemid ?? ""))
        }
        
        print("value ----->> \(value)")
        print("value ----->> \(databaseHandler.getCartCount())")
        print("getCartModelList ----->> \(databaseHandler.getCartModelList())")
        dump(databaseHandler.getCartModelList())

        self.cartAPICall()

   }

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
    
    @IBAction func checkoutPressed(){
        
       
    }
    
    
    
}
