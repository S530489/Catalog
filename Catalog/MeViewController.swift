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
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
            
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func LogoutACT(_ sender: Any) {
        PFUser.logOut()
        print("logout performed")
        
       //AppDelegate.pickerModel.users.remove(at: 0)
        
    }
    
  
    
    @IBAction func ChangePasswdACT(_ sender: Any) {
        
        let userEmail = AppDelegate.pickerModel.users[0].result?.email
        PFUser.requestPasswordResetForEmail(inBackground: userEmail!,
                                            block: { (success , error) -> Void in
                                                if(success){
                                                    self.displayOKAlert(title: "Success!",
                                                        message: "Email was sent to you at \(userEmail!)")
                                                    return
                                                }
                                                if(error != nil){
                                                    self.displayOKAlert(title: "Error in Recovery", message: "Error occured")
                                                    print("************************/n")
                                                    print(error!)
                                                }
        })
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
