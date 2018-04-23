//
//  model.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//


import Foundation
import Parse

class Item:PFObject, PFSubclassing {
    @NSManaged var name:String
    @NSManaged var quantity:Int
    @NSManaged var units:String
    @NSManaged var prefferedStore:String
    @NSManaged var category:String
    static func parseClassName() -> String {
        return "Item"
    } }

class Item1:PFObject, PFSubclassing {
    @NSManaged var name:String
    @NSManaged var quantity:Int
    @NSManaged var units:String
    @NSManaged var prefferedStore:String
    @NSManaged var category:String
    static func parseClassName() -> String {
        return "Wehave"
    } }

class User : PFObject,PFSubclassing {
    @NSManaged var name:String
    @NSManaged var email : String
    static func parseClassName() -> String {
        return "User"
    }}

class Model2{
    var userNameForEmail : String = ""
    var Category = ["Grocery", "Health", "Electronics", "Fashion", "Wines and Spirits", "Stationary"]
    var Unit = ["lbs", "Gallons", "Dozen", "Units"]
    var PreferedStores = ["Walmart", "Hyvee", "BestBuy", "Costco", "JCPenny", "Target"]
    var users : [BFTask<PFUser>] = []
//    init() {
//        self.users = []
//        self.fetchUser()
//    }
    
    func fetchUser(){
        var users : [BFTask<PFUser>] = []
        AppDelegate.pickerModel.users.append(PFUser.getCurrentUserInBackground())
    }
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
                //self.moviesTV.reloadData(
                
                self.catItems = []
                self.cat = []
                //        print(items.count)
                for c in AppDelegate.pickerModel.PreferedStores{
                    var temp : [Item] = []
                    
                    for i in self.items{
                        if c == i.prefferedStore{
                            temp.append(i)
                        }
                        
                    }
                    if temp.count > 0{
                        self.cat.append(c)
                        self.catItems.append(temp)
                    }
                    
                }
                //
                
            }
                
            else {
                // Log details of the failure
                //self.displayOKAlert(title: "Oops", message: "\(error!)")
                print("Error in loading the data")
                print(error!)
            } }
    }
}

