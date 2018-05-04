//
//  CatDetailViewController.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 04/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatDetailViewController : UIViewController {
    
    @IBOutlet weak var catImage: UIImageView!
    
    var cat = UIImage()
    
    override func viewDidLoad() {
        catImage.image = cat
        catImage.contentMode = .scaleAspectFit
    }
    
}
