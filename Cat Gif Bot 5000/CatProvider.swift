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
    var tableViewDelegate: TableViewProtocol?
    
    func getImage() {
        
        let url:URL = URL(string: self.baseUrl)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            
            do {
                if (response as? HTTPURLResponse) != nil {
                    
                    let image = UIImage.gif(data: data!)
                    self.tableViewDelegate?.didReceiveTableData(result: image)
                }
            }
        }
        
        task.resume()
        
    }
    
    func refreshCats() {
        for _ in 0...99 {
            getImage()
        }
        
    }
}
