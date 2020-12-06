//
//  OptionMenuViewController.swift
//  GrubChill
//
//  Created by Bharath Kumar on 03/12/20.
//

import UIKit

class OptionMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var option = [String]()
    
    var optionMenu = [optiongroupsData]()
    
    @IBOutlet weak var optionTable :UITableView!
    
    

    @IBOutlet  weak var addBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        headerView.configure(str: self.optionMenu[section].optiongroupname ?? "" )
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.optionMenu.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.optionMenu[section].options?.count ?? 0
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionMenuTableViewCell", for: indexPath as IndexPath) as! OptionMenuTableViewCell

        cell.optionLab.text = self.optionMenu[indexPath.section].options?[indexPath.row].optionname
        if(self.optionMenu[indexPath.section].options?[indexPath.row].selected == 0){
            cell.checkImg.image = UIImage(named: "checkbox.png")

        }else{
            cell.checkImg.image = UIImage(named: "uncheck.png")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(self.optionMenu[indexPath.section].options?[indexPath.row].selected == 0){
            self.optionMenu[indexPath.section].options?[indexPath.row].selected = 1
        }else{
            self.optionMenu[indexPath.section].options?[indexPath.row].selected = 0
        }
        
        self.optionTable.reloadData()
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
