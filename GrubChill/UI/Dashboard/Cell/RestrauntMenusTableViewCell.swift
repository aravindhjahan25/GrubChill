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
    @IBOutlet weak var subBtn: UIButton!

    @IBOutlet weak var QuantityView: UIView!
    @IBOutlet weak var addBtnQuantity: UIButton!


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
            QuantityView.isHidden = false
            addBtnQuantity.isHidden = true
        }else{
            QuantityView.isHidden = true
            addBtnQuantity.isHidden = false
        }
    }
}
