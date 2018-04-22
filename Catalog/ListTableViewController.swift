//
//  ListTableViewController.swift
//  Catalog
//
//  Created by Chandra Mouli on 3/9/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

// List containing functions for the table view to display the items in table view
class ListTableViewController: UITableViewController {
    
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
        AppDelegate.pickerModel.fetchItems()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.pickerModel.fetchItems()
        self.tableView.reloadData()
    }
    
    // Function for returning no. of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return AppDelegate.pickerModel.cat.count
    }
    
    // Function for returning no. of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.pickerModel.catItems[section].count
    }
    
    // Function for displaying the rows in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfItems", for: indexPath)
        let myItem  = cell.viewWithTag(100) as! UILabel
        let UnitsandQty = cell.viewWithTag(101) as! UILabel
        
        myItem.text = AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].name
        UnitsandQty.text = "\(AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].quantity)" + " " + "\(AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].units)"
        
        return cell
    }
    
    // function for returning the section header for the table view
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return AppDelegate.pickerModel.cat[section]
    }
    
    // Function for the swipe action inthe list table view the action displays a delete and bought button to rows in table view
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bought = boughtAction(at: indexPath)
        let delete = DeleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [bought,delete])
    }
    
    // Function for the delete action after the swipe function in called
    func DeleteAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action, view, completion) in
            AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].name) is deleted ")
      
        })
            completion(true)
        }

        action.image = #imageLiteral(resourceName: "del")
        action.backgroundColor = UIColor.red
        return action
    }
    
    // Function for the bought action after the swipe function in called
    func boughtAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "bought"){(action, view, completion) in
            
            let item = PFObject(className: "Wehave")
            item["name"] = AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].name
            item["quantity"] = AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].quantity
            item["units"] = AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].units
            item["prefferedStore"] = AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].prefferedStore
            item["category"] = AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].category
            
            
            item.saveInBackground(block: { (success, error) -> Void in
                if success {
                    print("\(AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].name) is successfully added to we have class")
                } else {
                    print(error as Any)
                }
            })
            
            AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].name) is Moved to Wehave List")
            })
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "bought")
        action.backgroundColor = .green
        return action
        
    }

}
