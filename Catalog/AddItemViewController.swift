//
//  AddItemViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 15/02/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemQuantityTF: UITextField!
    @IBOutlet weak var unitsTF: UITextField!
    @IBOutlet weak var preferedStoreTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

