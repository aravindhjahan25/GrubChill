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
    
    func configure(restrauntSingle: RestrauntList){
        cardView.cardDesign(shadowPath: false, radius: 8)
        labelCollection.text = restrauntSingle.name ?? ""
        let imageURL = restrauntSingle.logo ?? ""
        imageCollection.downloadImage(from: URL(string: imageURL)!)
    }
    
}
