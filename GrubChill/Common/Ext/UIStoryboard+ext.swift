//
//  StoryBoardName.swift
//  GrubChill
//
//  Created by Aravindh Jaganathan on 22/11/20.
//

import Foundation
import UIKit

extension UIStoryboard {
    struct named {
        static let main = UIStoryboard(name: "Main", bundle: nil)
        static let dashboard = UIStoryboard(name: "Dashboard", bundle: nil)
        static let sideMenu = UIStoryboard(name: "SideMenu", bundle: nil)
        static let cart = UIStoryboard(name: "Cart", bundle: nil)
        static let profile = UIStoryboard(name: "Profile", bundle: nil)
     }
}
