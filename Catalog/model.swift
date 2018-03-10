//
//  model.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import Foundation
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
        items = [item.init(name: "Egg", quantity: 30, units:unit.units,preferedStrore: stores.Walmart, category: "Grocery"),item.init(name: "Dove Soap", quantity: 3, units: unit.units,preferedStrore: stores.Walmart, category: "Health & Beauty"),item.init(name: "NoteBook", quantity: 5, units: unit.units,preferedStrore: stores.Costco, category: "Office Supplies"),item.init(name: "Head Phones", quantity: 1, units: unit.units,preferedStrore: stores.BestBuy, category: "Electronics"),item.init(name: "Bread", quantity: 2, units: unit.units,preferedStrore: stores.Walmart, category: "Grocery")]
        weHave = [item.init(name: "Milk", quantity: 2, units: unit.units, preferedStrore: stores.Target, category: "Grocery"),item.init(name: "Onions", quantity: 5, units: unit.lbs, preferedStrore: stores.Walmart, category: "Groccery")]
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
