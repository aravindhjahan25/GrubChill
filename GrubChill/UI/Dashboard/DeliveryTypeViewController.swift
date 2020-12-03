//
//  DeliveryTypeViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 03/12/20.
//

import UIKit

class DeliveryTypeViewController: UIViewController {
    
    @IBOutlet weak var pickupImg :UIImageView!
    @IBOutlet weak var deliveryImg :UIImageView!
    
    @IBOutlet weak var DeliveryType :UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedDeliveryType(_ sender : UIButton){
        

        if(sender.tag == 1){
            pickupImg.image = UIImage(named: "check-2.png")
            deliveryImg.image = UIImage(named: "check.png")

        }else{
            pickupImg.image = UIImage(named: "check.png")
            deliveryImg.image = UIImage(named: "check-2.png")
        }
        
    }
    
    @IBAction func dismisspopup(_ sender : UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
