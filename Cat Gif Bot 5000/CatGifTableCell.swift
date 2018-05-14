//
//  CatGifTableCell.swift
//  Cat Gif Bot 5000
//
//  Created by Tom van Nimwegen on 14/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatGifTableCell: UITableViewCell {
    
    @IBOutlet weak var gifView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
