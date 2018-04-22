//
//  WeHaveTableViewController.swift
//  Catalog
//
//  Created by Chandra Mouli on 3/9/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import  Parse
class WeHaveTableViewController: UITableViewController {
    
    var items:[Item1] = [];
    // Function for fetching the items from the parse database
    func fetchItems() {
        let query = PFQuery(className:"Wehave")     // Fetches all the Movie objects
        query.findObjectsInBackground {   // what happened to the ( ) ?
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.items = objects as! [Item1]
                self.tableView.reloadData()
            } else {
                self.displayOKAlert(title: "Oops", message: "\(error!)")
            } }
    }
    // Display alert function
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
        //print(self.items)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function for the swipe action inthe list table view the action displays a delete and bought button to rows in table view
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tobuy = ToBuy(at: indexPath)
        let delete = DeleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [tobuy,delete])
    }
    
     // Function for the delete action after the swipe function in called
    func DeleteAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action, view, completion) in
            self.items[indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(self.items[indexpath.row].name) is deleted ")
            })
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "del")
        action.backgroundColor = .red
        return action
    }
    
    // Function for the bought action after the swipe function in called
    func ToBuy(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "ToBuy"){(action, view, completion) in
            
            let item = PFObject(className: "Item")
            item["name"] = self.items[indexpath.row].name
            item["quantity"] = self.items[indexpath.row].quantity
            item["units"] = self.items[indexpath.row].units
            item["prefferedStore"] = self.items[indexpath.row].prefferedStore
            item["category"] = self.items[indexpath.row].category
            
            
            item.saveInBackground(block: { (success, error) -> Void in
                if success {
                    print("\(self.items[indexpath.row].name) is successfully added to List class")
                    AppDelegate.pickerModel.fetchItems()
                } else {
                    print(error as Any)
                }
            })
            
            self.items[indexpath.row].deleteInBackground(block:
                {(success,error) in
                    AppDelegate.pickerModel.fetchItems()
                    self.displayOKAlert(title: "Success!",
                                        message:"\(self.items[indexpath.row].name) is Moved to Required List")
            })
            completion(true)
        }
        
        
        action.backgroundColor = .gray
        action.image = #imageLiteral(resourceName: "tobuy")
        return action
        
    }
    // MARK: - Table view data source
    // Function for displaying no. of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Function for returning no. of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    // Function for displaying the cell information in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeHaveIdentifier", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
   
    
}
