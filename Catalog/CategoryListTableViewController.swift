//
//  CategoryListTableViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse
class CategoryListTableViewController: UITableViewController {
    
    var items:[Item] = [];
    var ItemsInCat:[Item] = [];
    
    // Action method for fetching all the items from parse
    func fetchItems() {
        let query = PFQuery(className:"Item")     // Fetches all the item objects
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.items = objects as! [Item]
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                self.displayOKAlert(title: "Oops", message: "\(error!)")
            } }
    }
    // Alert action method
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    
    // function for number of sections in the view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // function for returning number of rows in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppDelegate.pickerModel.Category.count
    }
    
    // function for returing the cell with the category name in it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryList", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = AppDelegate.pickerModel.Category[indexPath.row]
        return cell
    }
    // function for displaying the items in the selected(tapped) category by performing segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ItemsInCat = []
        let cat = AppDelegate.pickerModel.Category[indexPath.row]
        for i in items{
            if(i.category == cat){
                self.ItemsInCat.append(i)
            }
        }
        if ItemsInCat.count > 0{
            performSegue(withIdentifier: "CategoryToItem", sender: Any?.self)
        }
        else {
            // Everything went alright here
            self.displayOKAlert(title: AppDelegate.pickerModel.Category[indexPath.row], message:"No Items Found in the Category")
            
            
        }
        
        
    }
    
    // function to perform segue from categogy view controller to items in the category view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Destination = segue.destination as! ItemsInCategoryTableViewController
        
        
        Destination.items = ItemsInCat
    }
    
}
