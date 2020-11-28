//
//  RestrauntDetailHeaderCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 28/11/20.
//

import UIKit

class RestrauntDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var header: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(str: String){
        header.text = str
    }
    
}
