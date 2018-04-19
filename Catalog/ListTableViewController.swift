//
//  ListTableViewController.swift
//  Catalog
//
//  Created by Chandra Mouli on 3/9/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

class ListTableViewController: UITableViewController {
    
    var items:[Item] = []
    var catItems : [[Item]] = []
    var cat : [String] = []
    func fetchItems() {
        let query = PFQuery(className:"Item")     // Fetches all the Movie objects
        query.findObjectsInBackground {   // what happened to the ( ) ?
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
//                self.displayOKAlert(title: "Success!",
//                                    message:"Retrieved \(objects!.count) objects.")
                self.items = objects as! [Item]
                // Do something with the found objects
                // Like display them in a table view.
                //self.moviesTV.reloadData()
                self.tableView.reloadData()
                print(self.items)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
//    override func viewDidAppear(_ animated: Bool) {
//        fetchItems()
//        getStoreItems()
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
        getStoreItems()
        
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cat.count
    }
    
    func getStoreItems(){
            catItems = []
            cat = []
         print(items.count)
            for c in AppDelegate.pickerModel.PreferedStores{
                var temp : [Item] = []
               
                for i in items{
                    print(" c is \(c)")
                    print("i is \(i.preferedStore)")
                    if c == i.preferedStore{
                        temp.append(i)
                    }
                    print(temp)
            }
                if temp.count > 0{
                    cat.append(c)
                    catItems.append(temp)
                }
                
        }
        
      print(cat)
        print(catItems)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catItems[section].count
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfItems", for: indexPath)
        let myItem  = cell.viewWithTag(100) as! UILabel
        let UnitsandQty = cell.viewWithTag(101) as! UILabel
        
        myItem.text = catItems[indexPath.section][indexPath.row].name
        UnitsandQty.text = "\(catItems[indexPath.section][indexPath.row].quantity)" + " " + "\(catItems[indexPath.section][indexPath.row].units)"
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cat[section]
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bought = boughtAction(at: indexPath)
        let delete = DeleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [bought,delete])
    }
    
    func DeleteAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action, view, completion) in
            self.catItems[indexpath.section][indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(self.catItems[indexpath.section][indexpath.row].name) is deleted ")
            })
            completion(true)
        }
        //action.image = #imageLiteral(resourceName: "Trash")
        action.image = #imageLiteral(resourceName: "del")
        action.backgroundColor = .red
        return action
    }
    
    func boughtAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "bought"){(action, view, completion) in
            
            let item = PFObject(className: "Wehave")
            item["name"] = self.catItems[indexpath.section][indexpath.row].name
            item["quantity"] = self.catItems[indexpath.section][indexpath.row].quantity
            item["units"] = self.catItems[indexpath.section][indexpath.row].units
            item["prefferedStore"] = self.catItems[indexpath.section][indexpath.row].preferedStore
            item["category"] = self.catItems[indexpath.section][indexpath.row].category
            
            
            item.saveInBackground(block: { (success, error) -> Void in
                if success {
                    print("\(self.catItems[indexpath.section][indexpath.row].name) is successfully added to we have class")
                } else {
                    print(error as Any)
                }
            })
            
            self.catItems[indexpath.section][indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(self.catItems[indexpath.section][indexpath.row].name) is Moved to Wehave List")
            })
            completion(true)
        }
        
        //action.image = #imageLiteral(resourceName: "bought")
        action.image = #imageLiteral(resourceName: "bought")
        action.backgroundColor = .green
        return action
        
    }
    
    
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
