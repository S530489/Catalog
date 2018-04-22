//
//  MeViewController.swift
//  Catalog
//
//  Created by student on 2/15/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse
// class having functions for fetching the current user details from the parse
class MeViewController: UIViewController {
    
    @IBOutlet weak var userNameLBL: UILabel!
    
    @IBOutlet weak var userEmailLBL: UILabel!
    
    // function for fetching userName and Email from parse
    func fetchItems() {
        userNameLBL.text = AppDelegate.pickerModel.users[0].result?.username
        userEmailLBL.text = AppDelegate.pickerModel.users[0].result?.email
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    
}
