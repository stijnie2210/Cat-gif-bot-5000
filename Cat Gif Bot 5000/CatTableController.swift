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
    
    var catProvider:CatProvider = CatProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rc = UIRefreshControl()
        let scrollView = UIScrollView()
        self.tableView.refreshControl = rc
        scrollView.refreshControl = rc
        rc.addTarget(self, action: #selector(self.refresh(refreshControl:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(rc)
        
        loadIcon.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadCats()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadCats() {
        self.catProvider.refreshCats()
        
        DispatchQueue.main.async {
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
        //elf.tableView.addSubview(self.refreshControl)
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
        
        cell.imageView?.contentMode = .scaleAspectFit
        
        let cat = indexPath.row
        
        // Configure the cell...
        cell.textLabel?.text = ""
        cell.imageView?.image = catProvider.cats[cat]
        
        return cell
    }
    
}
