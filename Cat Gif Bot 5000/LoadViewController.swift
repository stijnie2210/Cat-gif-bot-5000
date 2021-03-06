//
//  LoadViewController.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class LoadViewController : UIViewController {
    
    @IBOutlet weak var LoadIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        LoadIndicator.startAnimating()
        performSegue(withIdentifier: "toMain", sender: self)
        
    }
}
