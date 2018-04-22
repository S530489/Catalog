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
        AppDelegate.pickerModel.fetchItems()
        // AppDelegate.pickerModel.getStoreItems()
        self.tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.pickerModel.fetchItems()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return AppDelegate.pickerModel.cat.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppDelegate.pickerModel.catItems[section].count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfItems", for: indexPath)
        let myItem  = cell.viewWithTag(100) as! UILabel
        let UnitsandQty = cell.viewWithTag(101) as! UILabel
        
        myItem.text = AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].name
        UnitsandQty.text = "\(AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].quantity)" + " " + "\(AppDelegate.pickerModel.catItems[indexPath.section][indexPath.row].units)"
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return AppDelegate.pickerModel.cat[section]
    }
    
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.gray
    //        let label = UILabel()
    //        label.text = AppDelegate.pickerModel.cat[section]
    //        label.textColor = UIColor.white
    //
    //
    //        return view
    //    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bought = boughtAction(at: indexPath)
        let delete = DeleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [bought,delete])
    }
    
    func DeleteAction(at indexpath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action, view, completion) in
            AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].deleteInBackground(block:
                {(success,error) in
                    self.displayOKAlert(title: "Success!",
                                        message:"\(AppDelegate.pickerModel.catItems[indexpath.section][indexpath.row].name) is deleted ")
            })
            completion(true)
        }
        //action.image = #imageLiteral(resourceName: "Trash")
        action.image = #imageLiteral(resourceName: "del")
        action.backgroundColor = UIColor.red
        return action
    }
    
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
