//
//  OptionMenuViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 03/12/20.
//

import UIKit

class OptionMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var option = [String]()

    @IBOutlet  weak var addBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        option = ["salad","chicken","topping","vanaili"]

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddBtnPressed(_ sender : UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func DismissPressed(_ sender : UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("RestrauntDetailHeaderCell", owner: self, options: nil)?.first as! RestrauntDetailHeaderCell
        headerView.configure(str: self.option[section] )
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.option.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionMenuTableViewCell", for: indexPath as IndexPath) as! OptionMenuTableViewCell
        cell.optionLab.text = option[indexPath.row]
        return cell
    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
