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
    @IBOutlet weak var loremText: UITextView!
    
    var cat = UIImage()
    let loremProvider = LoremProvider()
    
    override func viewDidLoad() {
        catImage.image = cat
        catImage.contentMode = .scaleAspectFit
        getLorem()
    }
    
    func getLorem() {
        DispatchQueue.main.async {
            self.loremProvider.getLorem()
            self.loremText.text = self.loremProvider.loremText
        }
    }
    
}
