//
//  LoremProvider.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 04/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation

class LoremProvider {
    
    let loremURL = "https://loripsum.net/api/plaintext"
    var loremText = String() {
        didSet {
            print("changed")
        }
    }
    
    func getLorem() {
        
        let url:URL = URL(string: self.loremURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let sema = DispatchSemaphore(value: 0);
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            
            do {
                if (response as? HTTPURLResponse) != nil {

                    let text = String(data: data!, encoding: .utf8)
                    self.loremText = text!
                }
            }
            sema.signal();
        }
        
        task.resume()
        sema.wait()

    }

    
}
