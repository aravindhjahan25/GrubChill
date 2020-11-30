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
    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var Quantity: UIView!


    func configure(itemSingle: Itemdata) {
        
        cardView.cardDesign(shadowPath: false, radius: 8)
        
        menuTitle.text = itemSingle.item ?? ""
        rate.text = "$ \(itemSingle.price ?? 0.0)"
        des.text = itemSingle.description ?? ""
        
        let imageURL = itemSingle.pic ?? ""
        if imageURL != "" {
            menuImage.downloadImage(from: URL(string: imageURL)!)
        }
    }
}
