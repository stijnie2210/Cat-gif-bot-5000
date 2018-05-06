//
//  Config.swift
//  Cat Gif Bot 5000
//
//  Created by Tom van Nimwegen on 06/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation

class Config {
    static var GifApi: URL {
        get{
            return URL(string: "https://thecatapi.com/api/")!;
        }
    }
    
    static var LoremApi: URL {
        get{
            return URL(string: "https://loripsum.net/api/")!;
        }
    }
}
