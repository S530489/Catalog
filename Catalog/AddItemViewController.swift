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
    
    //Outlet creation of three picker views
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var preferedStorePicker: UIPickerView!
    @IBOutlet weak var unitsPicker: UIPickerView!
    
    // function for no. of components in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Function for no. of rows in the component of picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
        return AppDelegate.pickerModel.Category.count
        } else if pickerView.tag == 2{
        return AppDelegate.pickerModel.PreferedStores.count
        }else {
            return AppDelegate.pickerModel.Unit.count
        }
    }
    var dummy:Int = 0
    var dummy1:Int = 0
    var dummy2:Int = 0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker{
            dummy = row
        } else if pickerView == preferedStorePicker{
            dummy1 = row
        } else {
            dummy2 = row
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker{
        return AppDelegate.pickerModel.Category[row]
        }
        else if pickerView == preferedStorePicker{
            return AppDelegate.pickerModel.PreferedStores[row]
        }else{
            return AppDelegate.pickerModel.Unit[row]
        }
    }
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemQuantityTF: UITextField!
    
//    @IBOutlet weak var unitsTF: UITextField!
//    @IBOutlet weak var preferedStoreTF: UITextField!
    @IBOutlet weak var errorMsgLBL: UILabel!
    
    @IBAction func AddItemBTN(sender: AnyObject) {
        if((itemNameTF.text?.isEmpty)! || (itemQuantityTF.text?.isEmpty)!)
//            || (unitsTF.text?.isEmpty)! || (preferedStoreTF.text?.isEmpty)!)
//            || (categoryTF.text?.isEmpty)!
        {
                                    errorMsgLBL.isHidden = false
                                    errorMsgLBL.text = "Fields cannot be empty."
        }
        else
        {
        let item = PFObject(className: "Item")
        item["name"] = itemNameTF.text
        item["quantity"] = Int(itemQuantityTF.text!)
//        item["units"] = unitsTF.text!
//        item["prefferedStore"] = preferedStoreTF.text
//        item["category"] = categoryTF.text
            item["units"] = AppDelegate.pickerModel.Unit[dummy2]
            item["prefferedStore"] = AppDelegate.pickerModel.PreferedStores[dummy1]
            item["category"] = AppDelegate.pickerModel.Category[dummy]
            

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

