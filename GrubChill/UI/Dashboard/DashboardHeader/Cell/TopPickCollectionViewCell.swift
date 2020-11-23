//
//  TopPickCollectionViewCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 23/11/20.
//

import UIKit

class TopPickCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var labelCollection: UILabel!
    
    func configure(textStr: String, image: String){
        cardView.cardDesign(shadowPath: false, radius: 8)
        labelCollection.text = textStr
        imageCollection.image = UIImage(named: image)
    }
    
}
