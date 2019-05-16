//
//  ITunesListViewController.swift
//  ITunesSearch
//
//  Created by William Moody on 5/16/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class ITunesListViewController: UIViewController {
    
    var results: [ITunesResults] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ITunesListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTuneCell", for: indexPath) as? ITunesItemTableViewCell
        
        let result = results[indexPath.row]
        
        cell?.iTunesResult = result
        cell?.artworkImageView.image = nil
        
        ITunesResultsController.fetchImageFor(iTunesItem: result) { (image) in
            DispatchQueue.main.async {
                cell?.artworkImageView.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension ITunesListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        ITunesResultsController.searchItunesFor(searchTerm: searchTerm) { (results) in
            self.results = results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
}
