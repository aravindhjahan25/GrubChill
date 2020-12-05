//
//  OrderListPopupViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 05/12/20.
//

import UIKit

class OrderListPopupViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var itemsTable : UITableView!
    
    var itemsMenu = [itemsData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DimissedPressed(_ sender : UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a reference to our storyboard cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath as IndexPath) as! OrderListTableViewCell
            
        
        if (itemsMenu.count == 0) {
            self.dismiss(animated: true, completion: nil)
        }else{
            cell.configure(itemSingle: (self.itemsMenu[indexPath.row]) )
        }
            
        return cell
      
    }
    
}
