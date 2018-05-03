//
//  CatTableController.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatTableController : UITableViewController, UpdateDelegate {
    
    
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    var catProvider:CatProvider = CatProvider()
    let updates = Updates()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIcon.startAnimating()
        updates.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadCats()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func didUpdate(sender: Updates) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadCats() {
        self.catProvider.refreshCats()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // TODO: Get playlist data and return number of rows based on array size
        return catProvider.cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
        
        cell.imageView?.contentMode = .scaleAspectFit
        
        
        // Configure the cell...
        
        let cat = indexPath.row
        cell.textLabel?.text = "test"
        cell.imageView?.image = catProvider.cats[cat]
        
        return cell
    }
    
}
