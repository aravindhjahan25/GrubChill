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

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configure(itemSingle: Itemdata) {
        
        ImgView.cardDesign(shadowPath: false, radius: 8)
        
        MenuLab.text = itemSingle.item ?? ""
        RateLab.text = "$ \(itemSingle.price ?? 0.0)"
        DesLab.text = itemSingle.description ?? ""
        
        let imageURL = itemSingle.pic ?? ""
        if imageURL != "" {
            MenuImg.downloadImage(from: URL(string: imageURL)!)
        }
    }

    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
