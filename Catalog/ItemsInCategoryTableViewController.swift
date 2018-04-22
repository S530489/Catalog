//
//  ItemsInCategoryTableViewController.swift
//  Catalog
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
// class containing functions for fetching, displaying items from the category selected.
class ItemsInCategoryTableViewController: UITableViewController {
    var items:[Item] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    // function for returning number of sections in the view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // function for returning number of rows in the setion
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    //function for returning the cell with item names for selected category
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsInCategory", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        // Configure the cell...
        
        return cell
    }
    
}
