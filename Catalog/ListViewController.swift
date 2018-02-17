//
//  ListViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 15/02/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let List_Array = ["Eggs","Milk","Potatos","Nutella","Water Bottles"]
    let Quantity = ["60","2","2","1","40"]
    let Units = ["pieces","Gallons","lbs","piece","pieces"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBuyItems")
        cell?.textLabel?.text = List_Array[indexPath.row]
        cell?.detailTextLabel?.text=Quantity[indexPath.row]+" "+Units[indexPath.row]
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

