//
//  UIImageView+ext.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 25/11/20.
//

import Foundation
import UIKit

extension UIImageView {
    
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }

   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
