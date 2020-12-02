//
//  RestrauntMenusTableViewCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 26/11/20.
//

import UIKit

class RestrauntMenusTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitle : UILabel!
    @IBOutlet weak var rate : UILabel!
    @IBOutlet weak var des : UILabel!
    @IBOutlet weak var QuantityLab : UILabel!

    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var subBtn: UIButton!

    @IBOutlet weak var Quantity: UIView!

    @IBOutlet weak var QuantityView: UIStackView!


    func configure(itemSingle: Itemdata) {
        
        cardView.cardDesign(shadowPath: false, radius: 8)
        
        menuTitle.text = itemSingle.item ?? ""
        rate.text = "$ \(itemSingle.price ?? 0.0)"
        des.text = itemSingle.description ?? ""
        QuantityLab.text = "\(itemSingle.quantity ?? 0)"

        
        let imageURL = itemSingle.pic ?? ""
        if imageURL != "" {
            menuImage.downloadImage(from: URL(string: imageURL)!)
        }
        
        if(itemSingle.quantity != 0){
            addBtn.isHidden = false
            add.isHidden = true
        }else{
            addBtn.isHidden = true
            add.isHidden = false
        }
    }
}
