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
    @NSManaged var preferedStore:String
    @NSManaged var category:String
    static func parseClassName() -> String {
        return "Item"
    } }

class Item1:PFObject, PFSubclassing {
    @NSManaged var name:String
    @NSManaged var quantity:Int
    @NSManaged var units:String
    @NSManaged var preferedStore:String
    @NSManaged var category:String
    static func parseClassName() -> String {
        return "Wehave"
    } }

class Model2{
    var Category = ["Grocery", "Health", "Electronics", "Fashion", "Wines and Spirits", "Stationary"]
    var Unit = ["lbs", "Gallons", "Dozen", "Units"]
    var PreferedStores = ["Walmart", "Hyvee", "BestBuy", "Costco", "JCPenny", "Target"]
    
}
enum stores{
    case Walmart, Hyvee,BestBuy,Costco,JCPenny,Target
}
enum unit {
    case lbs,units
}

struct item{
    var name : String
    var quantity : Int
    var units : unit
    var preferedStrore : stores
    var category : String
    
}

class model {
    var categories : [String]
    var items : [item]
    var weHave : [item] = []
    
    init() {
        categories = []
        items = []
        self.loadInitailData()
        self.categoriesList()
    }
    func loadInitailData(){
        items = [item.init(name: "Egg", quantity: 30, units:unit.units,preferedStrore: stores.Walmart, category: "Grocery"),item.init(name: "Dove Soap", quantity: 3, units: unit.units,preferedStrore: stores.Walmart, category: "Health & Beauty"),item.init(name: "NoteBook", quantity: 5, units: unit.units,preferedStrore: stores.Costco, category: "Office Supplies"),item.init(name: "Head Phones", quantity: 1, units: unit.units,preferedStrore: stores.BestBuy, category: "Electronics"),item.init(name: "Bread", quantity: 2, units: unit.units,preferedStrore: stores.Walmart, category: "Grocery"),item.init(name: "beers", quantity: 100, units: unit.units, preferedStrore: stores.Hyvee, category: "Liqour"),item.init(name: "chicken", quantity: 30, units: unit.units, preferedStrore: stores.Walmart, category: "Meat"),item.init(name: "milk", quantity: 50, units: unit.units, preferedStrore: stores.Walmart, category: "Grocery"),item.init(name: "chillies", quantity: 100, units: unit.units, preferedStrore: stores.Walmart, category: "veg"),item.init(name: "Apples", quantity: 120, units: unit.units, preferedStrore: stores.Hyvee, category: "fruits"),item.init(name: "lays", quantity: 100, units: unit.units, preferedStrore: stores.Hyvee, category: "Grocery"),item.init(name: "pepe jens", quantity: 95, units: unit.units, preferedStrore: stores.JCPenny, category: "clothes"),item.init(name: "allen solly", quantity: 58, units: unit.units, preferedStrore: stores.JCPenny, category: "clothes"),item.init(name: "T.V", quantity: 15, units: unit.units, preferedStrore: stores.BestBuy, category: "Eleectronics"),item.init(name: "bounty", quantity: 1000, units: unit.units, preferedStrore: stores.Costco, category: "Grocery"),item.init(name: "Malboro", quantity: 1000, units: unit.units, preferedStrore: stores.Hyvee, category: "Life hacker")]
        
        weHave.append(item.init(name: "Milk", quantity: 2, units: unit.units, preferedStrore: stores.Hyvee, category: "Grocery"))
        weHave.append(item.init(name: "Rice", quantity: 1, units: unit.units, preferedStrore: stores.Hyvee, category: "Grocery"))
    }
    func addItem(name : String, quantity : Int,units : String,PreferedStore: String,category : String) {
        items.append(item.init(name: name, quantity: quantity, units: unit.lbs, preferedStrore: stores.Walmart, category: category))
    }
    func categoriesList(){
        for i in 0..<items.count{
            if(categories.contains(items[i].category)){
                
            }
            else{
                categories.append(items[i].category)
            }
        }
    }
    func findItemsInCategory(category : String)->[item]{
        var tempItemsInCategory : [item] = []
        for i in 0..<items.count{
            if(items[i].category == category){
                tempItemsInCategory.append(items[i])
            }
        }
        return tempItemsInCategory
    }
}

struct LoginData{
    var Name:String
    var Email:String
    var Password:String
    
}
class Login {
    var Login : [LoginData]
    
    init() {
        self.Login = []
        self.loginData()
    }
    
    func loginData(){
        Login.append(LoginData.init(Name: "manas", Email: "manas@gmail.com", Password: "manas"))
        Login.append(LoginData.init(Name: "sai", Email: "sai@gmail.com", Password: "sai"))
        Login.append(LoginData.init(Name: "shiva", Email: "shiva@gmail.com", Password: "shiva"))
        Login.append(LoginData.init(Name: "mouli", Email: "mouli@gmail.com", Password: "mouli"))
        Login.append(LoginData.init(Name: "hitesh", Email: "hitesh@gmail.com", Password: "hitesh"))
    }
    
    func login(name: String, password: String) -> Bool{
        var a:Bool = false
        for i in 0..<Login.count{
            if (Login[i].Name == name) && (Login[i].Password == password) {
                a = true
            }
            else{
                a = false
            }
        }
        return a
    }
    
    
    func signUp(name: String, email: String, password: String) {
        Login.append(LoginData.init(Name: name, Email: email, Password: password))
    }
}















