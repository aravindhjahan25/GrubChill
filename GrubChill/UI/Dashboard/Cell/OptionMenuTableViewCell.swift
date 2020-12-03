//
//  OptionMenuTableViewCell.swift
//  GrubChill
//
//  Created by Bharath Kumar on 03/12/20.
//

import UIKit

class OptionMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionLab : UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
