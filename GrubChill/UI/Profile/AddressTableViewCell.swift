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


    func configure(Addressdata: AddressDTO) {

        address1Lab.text = Addressdata.address1
        address2Lab.text = Addressdata.address2
        stateLab.text = Addressdata.state
        cityLab.text = Addressdata.city
        zipcodeLab.text = Addressdata.zipcode
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
