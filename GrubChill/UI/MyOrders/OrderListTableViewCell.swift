//
//  OrderListTableViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 05/12/20.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MenuLab : UILabel!
    @IBOutlet weak var RateLab : UILabel!
    @IBOutlet weak var DesLab : UILabel!
    @IBOutlet weak var QuantityLab : UILabel!
    @IBOutlet weak var TotalPriceLab : UILabel!

    @IBOutlet weak var MenuImg : UIImageView!
    
    @IBOutlet weak var ImgView : UIView!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(itemSingle: itemsData) {
        
        ImgView.cardDesign(shadowPath: false, radius: 8)
        
        MenuLab.text = itemSingle.item ?? ""
        RateLab.text = "$ \(itemSingle.price ??  0)"
        DesLab.text = itemSingle.description ?? ""
        QuantityLab.text = itemSingle.qty
        TotalPriceLab.text = "$ \(itemSingle.qty_price ?? 0)"
        
        
        let imageURL =  ""
        if imageURL != "" {
            MenuImg.downloadImage(from: URL(string: imageURL)!)
        }
    }


}
