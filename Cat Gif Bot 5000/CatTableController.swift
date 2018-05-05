//
//  CatTableController.swift
//  Cat Gif Bot 5000
//
//  Created by Stijn Mommersteeg on 03/05/2018.
//  Copyright © 2018 StijnEnTom inc. All rights reserved.
//

import Foundation
import UIKit

class CatTableController : UITableViewController, TableViewProtocol {
    
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    let catProvider = CatProvider()
    var cats = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catProvider.tableViewDelegate = self
        tableviewConfig()
        loadIcon.startAnimating()
        
        DispatchQueue.main.async {
            self.loadCats()
        }
        
    }
    
    func tableviewConfig() {
        let rc = UIRefreshControl()
        let scrollView = UIScrollView()
        
        tableView.refreshControl = rc
        scrollView.refreshControl = rc
        
        rc.addTarget(self, action: #selector(self.refresh(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(rc)

    }
    
    func didReceiveTableData(result: UIImage?) {
        if result != nil {
            DispatchQueue.main.async {
                self.cats.append(result!)
                self.tableView.reloadData()
            }
            loadIcon.stopAnimating()
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadCats() {
        self.catProvider.refreshCats()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        cats.removeAll()
        tableView.reloadData()
        
        DispatchQueue.main.async {
            self.loadCats()
            refreshControl.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as UITableViewCell
            
        let cat = indexPath.row
        let image = self.cats[cat]
        let imageView = cell.imageView
        imageView?.sizeToFit()
            
        // Configure the cell...
        cell.textLabel?.text = ""
        imageView?.image = image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "toDetail") {
            let cat = self.cats[tableView.indexPathForSelectedRow!.row]
            
            if let details = segue.destination as? CatDetailViewController {
                details.cat = cat
            }
        }
        
    }
    
}
