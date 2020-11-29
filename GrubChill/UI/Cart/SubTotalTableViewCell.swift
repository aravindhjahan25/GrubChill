//
//  SubTotalTableViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 28/11/20.
//

import UIKit

class SubTotalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var taxLab : UILabel!
    @IBOutlet weak var taxPrice : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.cardDesign(shadowPath: false, radius: 8)
        
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
