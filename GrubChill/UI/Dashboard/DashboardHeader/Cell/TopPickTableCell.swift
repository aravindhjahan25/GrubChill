//
//  TopPickTableCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit

class TopPickTableCell: UITableViewCell {
    
    @IBOutlet weak var label : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(labelStr: String) {
        label.text = labelStr
    }
    

}
