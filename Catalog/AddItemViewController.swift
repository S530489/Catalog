//
//  AddItemViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 15/02/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppDelegate.pickerModel.Category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AppDelegate.pickerModel.Category[row]
    }
    
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemQuantityTF: UITextField!
    @IBOutlet weak var unitsTF: UITextField!
    @IBOutlet weak var preferedStoreTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var errorMsgLBL: UILabel!
    
//    @IBAction func AddItemBTN(_ sender: Any) {
//
//        if((itemNameTF.text?.isEmpty)! || (itemQuantityTF.text?.isEmpty)! || (unitsTF.text?.isEmpty)! || (preferedStoreTF.text?.isEmpty)! || (categoryTF.text?.isEmpty)!){
//            errorMsgLBL.isHidden = false
//            errorMsgLBL.text = "Fields cannot be empty."
//        }
//        else{
//            AppDelegate.myModel.addItem(name: itemNameTF.text!, quantity: Int(itemQuantityTF.text!)!, units: unitsTF.text!, PreferedStore: preferedStoreTF.text!, category: categoryTF.text!)
//            self.performSegue(withIdentifier: "AddVCToListVC", sender: Any?.self)
//        }
//    }
    

    
    
    @IBAction func AddItemBTN(sender: AnyObject) {
        if((itemNameTF.text?.isEmpty)! || (itemQuantityTF.text?.isEmpty)! || (unitsTF.text?.isEmpty)! || (preferedStoreTF.text?.isEmpty)! || (categoryTF.text?.isEmpty)!){
                                    errorMsgLBL.isHidden = false
                                    errorMsgLBL.text = "Fields cannot be empty."
        }
        else
        {
        let item = PFObject(className: "Item")
        item["name"] = itemNameTF.text
        item["quantity"] = Int(itemQuantityTF.text!)
        item["units"] = Int(unitsTF.text!)
        item["prefferedStore"] = preferedStoreTF.text
        item["category"] = categoryTF.text
        

        item.saveInBackground(block: { (success, error) -> Void in
            if success {
                self.displayOKAlert(title: "Success!", message:"Item saved.")
            } else {
                print(error as Any)
            }
        })
            
        }
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
        errorMsgLBL.isHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
    }


}

