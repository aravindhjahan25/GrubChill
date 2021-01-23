//
//  AddressCollectionViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 29/11/20.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var AddressLab : UILabel!
    @IBOutlet weak var cityLab : UILabel!
    @IBOutlet weak var zipcodeLab : UILabel!
    @IBOutlet weak var SelectButton : UIButton!
    
    func configure(Addressdata: [String:Any]) {

        AddressLab.text = "\(Addressdata["address1"] as? String ?? ""), \(Addressdata["address2"] as? String ?? "")"
        cityLab.text = "\(Addressdata["city"] as? String ?? ""), \(Addressdata["state"] as? String ?? "")"
        zipcodeLab.text = Addressdata["zipcode"] as? String
       }

}
