//
//  DashboardTableViewCell.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 26/11/20.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var restrauntName: UILabel!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var address: UILabel!

    func configure(restrauntSingle: RestrauntList){
        cardView.cardDesign(shadowPath: false, radius: 8)
        restrauntName.text = restrauntSingle.name ?? ""
        
        secondName.text = "\(restrauntSingle.categoryone ?? ""), \(restrauntSingle.categorytwo ?? "" )"
        address.text = "\(restrauntSingle.address ?? ""), \(restrauntSingle.city ?? ""), \(restrauntSingle.state ?? ""), \(restrauntSingle.country ?? "")"
        
        let imageURL = restrauntSingle.logo ?? ""
        imageCollection.downloadImage(from: URL(string: imageURL)!)
    }

}
