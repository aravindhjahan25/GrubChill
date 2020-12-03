//
//  MyOrdersViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 04/12/20.
//

import UIKit

class MyOrdersViewController: BaseController ,UITableViewDataSource ,UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // get a reference to our storyboard cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath as IndexPath) as! MyOrderTableViewCell
           
           // Use the outlet in our custom class to get a reference to the UILabel in the cell
//        cell.restaurantLab.text = self.restaurantName[indexPath.row] // The row value is the same as the index of the desired text within the array.
//           cell.restaurantImg.image = self.restaurantImg[indexPath.row]
//
//        cell.restaurantAddress.text = self.restaurantAddress[indexPath.row]
                      
           return cell
       
        
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
