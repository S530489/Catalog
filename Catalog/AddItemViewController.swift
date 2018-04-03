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
    @IBOutlet weak var errorMsgLBL: UILabel!
    
    @IBAction func AddItemBTN(_ sender: Any) {
        if((itemNameTF.text?.isEmpty)! || (itemQuantityTF.text?.isEmpty)! || (unitsTF.text?.isEmpty)! || (preferedStoreTF.text?.isEmpty)! || (categoryTF.text?.isEmpty)!){
            errorMsgLBL.text = "Fields cannot be empty."
        }
        else{
            AppDelegate.myModel.addItem(name: itemNameTF.text!, quantity: Int(itemQuantityTF.text!)!, units: unitsTF.text!, PreferedStore: preferedStoreTF.text!, category: categoryTF.text!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMsgLBL.isHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

