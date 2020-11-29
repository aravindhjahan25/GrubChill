//
//  CartTableViewCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 29/11/20.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        cardView.cardDesign(shadowPath: false, radius: 8)
    }

}
