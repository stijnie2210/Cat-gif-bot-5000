//
//  CatProvider.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatProvider {
    
    let baseUrl = "https://thecatapi.com/api/images/get?format=src&type=gif"
    var cats = [UIImage]()
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.global().async {
                let image = UIImage(data: data)
                self.cats.append(image!)
                group.leave()
            }
            group.wait()
            if(self.cats.count == 10) {
                let updates = Updates()
                updates.sendUpdate()
                
            }
        }
    }
    
    func refreshCats() {
        for _ in 0...9 {
            downloadImage(url: URL(string: "https://thecatapi.com/api/images/get?format=src&type=gif")!)
        }
        
    }
}
