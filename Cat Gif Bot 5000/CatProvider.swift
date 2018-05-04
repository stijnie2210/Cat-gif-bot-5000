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
    
    func getImage() {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            let gif = UIImage.gif(url: self.baseUrl)
            if(gif == nil) {
                return self.getImage()
            }
            self.cats.append(gif!)
            group.leave()
        }
        group.wait()
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

        }
    }
    
    func refreshCats() {
        cats.removeAll()
        for _ in 0...9 {
            getImage()
        }
        
    }
}
