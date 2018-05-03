//
//  Updates.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation

class Updates {
    var delegate: UpdateDelegate?
    
    
    //Indicates progress finished
    func sendUpdate() {
        self.delegate?.didUpdate(sender: self)
    }
}
