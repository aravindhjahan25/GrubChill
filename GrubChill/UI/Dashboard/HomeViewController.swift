//
//  HomeViewController.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import UIKit

class HomeViewController: BaseController,
                          UICollectionViewDataSource{

    @IBOutlet weak var topPickUp: UICollectionView!
    
    let imageArray = [
            "french.png",
            "noodle.png",
            "dishitem5.png",
            "french.png",
            "noodle.png",
            "dishitem5.png",
            "french.png",
            "noodle.png",
            "dishitem5.png"
        ]
    
    let titleArray = [
            "French",
            "Noodles",
            "Ice Cream",
            "French",
            "Noodles",
            "Ice Cream",
            "French",
            "Noodles",
            "Ice Cream"
        ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        topPickUp.reloadData()
        
        super.viewWillAppear(animated)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPickCollectionViewCell", for: indexPath as IndexPath) as! TopPickCollectionViewCell
        cell.configure(textStr: self.titleArray[indexPath.row], image: self.imageArray[indexPath.row])
        return cell
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
    func cardDesign(shadowPath : Bool, radius : CGFloat) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        if shadowPath{
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
            layer.shadowPath = shadowPath.cgPath
        }
        layer.shadowOpacity = 0.3
    }
}
