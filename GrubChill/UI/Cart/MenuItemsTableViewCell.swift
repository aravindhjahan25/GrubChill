//
//  MenuItemsTableViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 28/11/20.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MenuLab : UILabel!
    @IBOutlet weak var RateLab : UILabel!
    @IBOutlet weak var DesLab : UILabel!
    @IBOutlet weak var QuantityLab : UILabel!
    @IBOutlet weak var TotalPriceLab : UILabel!



    @IBOutlet weak var MenuImg : UIImageView!
    
    @IBOutlet weak var ImgView : UIView!
    
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var SubButton : UIButton!

    
    func configure(itemSingle: CartItemData) {
        
        ImgView.cardDesign(shadowPath: false, radius: 8)
        
        MenuLab.text = itemSingle.item ?? ""
        RateLab.text = "$ \(itemSingle.price ?? 0.0)"
        DesLab.text = itemSingle.description ?? ""
        QuantityLab.text = "\(itemSingle.qty ?? 0)"
        
        let imageURL = itemSingle.pic ?? ""
        if imageURL != "" {
            MenuImg.downloadImage(from: URL(string: imageURL)!)
        }
    }

    
}
