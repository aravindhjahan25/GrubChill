//
//  CartListVc.swift
//  GrubChill
//
//  Created by mac on 09/01/21.
//

import UIKit
import ProgressHUD
import Alamofire
import RxSwift
import RxCocoa

class CartListVc: BaseController ,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    private let cartViewVM = CartViewModel()
    private let disposebag = DisposeBag()
    
    
    @IBOutlet weak var cartTableView : UITableView!
    
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
    
    @IBOutlet weak var cardNoView: TextBoxView!
    @IBOutlet weak var ExpmonthView: TextBoxView!
    @IBOutlet weak var ExpyearView: TextBoxView!
    @IBOutlet weak var cvvView: TextBoxView!
    @IBOutlet weak var zipcodeView: TextBoxView!
    
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var userName: UITextField!


    var cartMenu = CartDTO()
    
    var databaseHandler = DatabaseHandler()
    
    var cartResponse = CartResponseDTO()
    
    var delivery_type:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartViewVM.cartView = self
        
        //RX Binding values
        cardNo.rx.text.map{ $0 ?? ""}.bind(to: cartViewVM.cardNoPublishObject).disposed(by: disposebag)
        Expyear.rx.text.map{ $0 ?? ""}.bind(to: cartViewVM.yearPublishObject).disposed(by: disposebag)
        Expmonth.rx.text.map{ $0 ?? ""}.bind(to: cartViewVM.monthPublichObject).disposed(by: disposebag)
        cvv.rx.text.map{ $0 ?? ""}.bind(to: cartViewVM.cvvPublichObject).disposed(by: disposebag)
        zipcode.rx.text.map{ $0 ?? ""}.bind(to: cartViewVM.zipcodePublichObject).disposed(by: disposebag)
        
        
        cartViewVM.isValidValue.asObservable().subscribe(onNext: {[weak self] (doesContain) in
            print("\(doesContain)")
            self?.cardNoView.borderColor = doesContain ? UIColor.lightGray : UIColor.red
            
            
        }).disposed(by:disposebag)
        
        
        showEmptyView.isHidden = false
        billingView.isHidden = true
        billingheightConstraint.constant = 0
        
        pickUpSelectedImage.image = UIImage(named: "check-2.png")
        deliverySelectedImage.image = UIImage(named: "check.png")
        
        self.userinfofill()
        
        
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
                cartSingle["item"] = index.item
            
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
    
    func showToast(message : String , color : UIColor) {

        let toastLabel = UILabel(frame: CGRect(x: 20 , y: self.view.frame.size.height-100, width: self.view.frame.width - 40, height: 50))
        toastLabel.backgroundColor = color.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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

        
//        dump(databaseHandler.getCartModelList())
    
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
        
        delivery_type = "Pickup"
        billingView.isHidden = true
        billingheightConstraint.constant = 0
        
        pickUpSelectedImage.image = UIImage(named: "check-2.png")
        deliverySelectedImage.image = UIImage(named: "check.png")
        
    }
    
    @IBAction func deliveryBtn(_ sender: UIButton){
        
        delivery_type = "Delivery"
        
        billingheightConstraint.constant = 205
        billingView.isHidden = false
        
        pickUpSelectedImage.image = UIImage(named: "check.png")
        deliverySelectedImage.image = UIImage(named: "check-2.png")
        
    }
    
    @IBAction func checkoutPressed(){
       
        cartViewVM.vaildator()
        cartViewVM.checkoutAPI()
    }
    
    func vaildation() -> Bool{
        var vaild : Bool = true
        if (cardNo.text!.count != 16) {
            cardNo.layer.borderWidth = 0.5
            cardNo.layer.borderColor = UIColor.red.cgColor
            vaild = false
        }
        if (Expmonth.text!.count != 2) {
            Expmonth.layer.borderWidth = 0.5
            Expmonth.layer.borderColor = UIColor.red.cgColor
            vaild = false
        }
    
        if (Expyear.text!.count != 2) {
            Expyear.layer.borderWidth = 0.5
            Expyear.layer.borderColor = UIColor.red.cgColor
            vaild = false
        }
        if (cvv.text!.count != 3) {
            cvv.layer.borderWidth = 0.5
            cvv.layer.borderColor = UIColor.red.cgColor
            vaild = false
        }
        return vaild
    }
    
//    func textField(_ textField: UITextField,
//                   shouldChangeCharactersIn range: NSRange,
//                     replacementString string: String)-> Bool{
//        
//            cardNo.layer.borderWidth = 0
//            Expmonth.layer.borderWidth = 0
//            Expyear.layer.borderWidth = 0
//            cvv.layer.borderWidth = 0
//        if (textField == cardNo) {
//            if (cardNo.text!.count == 16) {
//                textField.resignFirstResponder()
//            }
//        }
//        if(textField == Expmonth){
//            if (Expmonth.text!.count == 2) {
//                textField.resignFirstResponder()
//            }
//        }
//        if(textField == Expyear){
//            if (Expyear.text!.count == 2) {
//                textField.resignFirstResponder()
//            }
//        }
//        if(textField == cvv){
//            if (cvv.text!.count == 3) {
//                textField.resignFirstResponder()
//            }
//        }
//        
//        return true
//    }
//    
}
