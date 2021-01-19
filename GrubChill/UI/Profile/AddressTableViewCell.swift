//
//  AddressTableViewCell.swift
//  GrubChill
//
//  Created by mac on 13/01/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var address1Lab: UILabel!
    @IBOutlet weak var address2Lab: UILabel!
    @IBOutlet weak var stateLab: UILabel!
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var zipcodeLab: UILabel!


    func configure(Addressdata: [String:Any]) {

        address1Lab.text = Addressdata["address1"] as? String
        address2Lab.text = Addressdata["address2"] as? String
        stateLab.text = Addressdata["state"] as? String
        cityLab.text = Addressdata["city"] as? String
        zipcodeLab.text = Addressdata["zipcode"] as? String
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
