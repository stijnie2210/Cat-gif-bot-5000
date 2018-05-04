//
//  CatTableController.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatTableController : UITableViewController {
    
    
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    var catProvider = CatProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadIcon.hidesWhenStopped = true
        let rc = UIRefreshControl()
        let scrollView = UIScrollView()
        self.tableView.refreshControl = rc
        scrollView.refreshControl = rc
        rc.addTarget(self, action: #selector(self.refresh(refreshControl:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(rc)
        
        loadIcon.startAnimating()
        
        DispatchQueue.main.async {
            self.loadCats()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadCats() {
        
        
        DispatchQueue.main.async {
            self.catProvider.refreshCats()
            self.refreshControl?.beginRefreshing()
            self.tableView.reloadData()
            self.loadIcon.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        loadIcon.startAnimating()
        loadCats()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catProvider.cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as UITableViewCell
        
        //cell.imageView?.contentMode = .scaleAspectFit
        
        let cat = indexPath.row
        let image = catProvider.cats[cat]
        let imageView = cell.imageView
        imageView?.sizeToFit()
        
        // Configure the cell...
        cell.textLabel?.text = ""
        imageView?.image = image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "toDetail") {
            let cat = self.catProvider.cats[tableView.indexPathForSelectedRow!.row]
            
            if let details = segue.destination as? CatDetailViewController {
                details.cat = cat
            }
        }
        
    }
    
}
