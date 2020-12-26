//
//  CartTableViewCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 29/11/20.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var MenuLab : UILabel!
    @IBOutlet weak var RateLab : UILabel!
    @IBOutlet weak var DesLab : UILabel!
    @IBOutlet weak var QuantityLab : UILabel!
    @IBOutlet weak var TotalPriceLab : UILabel!



    @IBOutlet weak var MenuImg : UIImageView!
    
    
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var SubButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(itemSingle: CartItemData){
        cardView.cardDesign(shadowPath: false, radius: 8)
        
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
