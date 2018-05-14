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
    var latestIndex = Int()
    
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
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let rc = UIRefreshControl()
        let scrollView = UIScrollView()
        
        tableView.refreshControl = rc
        scrollView.refreshControl = rc
        
        rc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(rc)

    }
    
    func didReceiveTableData(result: UIImage?) {
        if result != nil {
            DispatchQueue.main.async {
                self.cats.append(result!)
                self.latestIndex = self.cats.endIndex - 1
                let indexPath = IndexPath(row: self.latestIndex, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .none)
                self.tableView.cellForRow(at: indexPath)
            }
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadCats() {
        self.catProvider.refreshCats()
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.loadIcon.stopAnimating()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        cats.removeAll()
        tableView.reloadData()
        
        DispatchQueue.main.async {
            self.loadCats()
        }
        refreshControl.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! CatGifTableCell
        let cat = indexPath.row
        let image = self.cats[cat]
        
        let imageView = cell.gifView
        imageView?.image = image
        
        //let cellImg : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        //cellImg.image = image
        //tableView.rowHeight = image.size.height
        //cell.addSubview(cellImg)
        
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
