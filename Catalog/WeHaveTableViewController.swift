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
    
    func fetchItems() {
        let query = PFQuery(className:"Wehave")     // Fetches all the Movie objects
        query.findObjectsInBackground {   // what happened to the ( ) ?
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                //                self.displayOKAlert(title: "Success!",
                //                                    message:"Retrieved \(objects!.count) objects.")
                self.items = objects as! [Item1]
                // Do something with the found objects
                // Like display them in a table view.
                //self.moviesTV.reloadData()
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                self.displayOKAlert(title: "Oops", message: "\(error!)")
            } }
    }
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tobuy = ToBuy(at: indexPath)
        let delete = DeleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [tobuy,delete])
    }
    
    func DeleteAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action, view, completion) in
            self.items[indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(self.items[indexpath.row].name) is deleted ")
            })
            completion(true)
        }
        //action.image = #imageLiteral(resourceName: "Trash")
        action.image = #imageLiteral(resourceName: "del")
        action.backgroundColor = .red
        return action
    }
    
    func ToBuy(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "ToBuy"){(action, view, completion) in
            
            let item = PFObject(className: "Item")
            item["name"] = self.items[indexpath.row].name
            item["quantity"] = self.items[indexpath.row].quantity
            item["units"] = self.items[indexpath.row].units
            item["prefferedStore"] = self.items[indexpath.row].preferedStore
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
        
        //action.image = #imageLiteral(resourceName: "bought")
        action.backgroundColor = .gray
        action.image = #imageLiteral(resourceName: "tobuy")
        return action
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeHaveIdentifier", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeHaveIdentifier", for: indexPath)
//
//        // Configure the cell...
//        cell.textLabel?.text = items[indexPath.row].name
//        return cell
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
