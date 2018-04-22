//
//  AddItemViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 15/02/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse
// class having functions for adding an item into the list
class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemQuantityTF: UITextField!
    @IBOutlet weak var errorMsgLBL: UILabel!
    
    //Outlet creation of three picker views
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var preferedStorePicker: UIPickerView!
    @IBOutlet weak var unitsPicker: UIPickerView!
    // stepper action for increasing the quantity of adding item
    @IBAction func stepperAction(_ sender: UIStepper) {
        //        itemQuantityTF.text = (sender as AnyObject).text
        itemQuantityTF.text = String(Int(sender.value))
        
    }
    
    
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
    
    // function for knowing which row has been selected in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker{
            dummy = row
        } else if pickerView == preferedStorePicker{
            dummy1 = row
        } else {
            dummy2 = row
        }
    }
    // function for populating the data of the picker view
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
    
    
    // Action method to add an item to the buying list
    @IBAction func AddItemBTN(sender: AnyObject) {
        if((itemNameTF.text?.isEmpty)! || (itemQuantityTF.text?.isEmpty)!)
        {
            errorMsgLBL.isHidden = false
            errorMsgLBL.text = "Fields cannot be empty."
        }
        else
        {
            let item = PFObject(className: "Item")
            item["name"] = itemNameTF.text
            item["quantity"] = Int(itemQuantityTF.text!)
            item["units"] = AppDelegate.pickerModel.Unit[dummy2]
            item["prefferedStore"] = AppDelegate.pickerModel.PreferedStores[dummy1]
            item["category"] = AppDelegate.pickerModel.Category[dummy]
            
            
            item.saveInBackground(block: { (success, error) -> Void in
                if success {
                    AppDelegate.pickerModel.fetchItems()
                    self.displayOKAlert(title: "Success!", message:"\(self.itemNameTF.text ?? "item") is added to List.")
                    self.itemNameTF.text?.removeAll()
                    //                self.itemQuantityTF.text? = "1"
                } else {
                    print(error as Any)
                }
            })
            
        }
    }
    // Alert action 
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

