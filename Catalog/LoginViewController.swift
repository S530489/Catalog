//
//  LoginViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    

    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        var a:Bool = false
//        
//        if identifier == "login" {
//        a = AppDelegate.login.login(name: usernameTF.text!, password: passwordTF.text!)
//        }
//        else {
//            
//        }
//        return a
//    }
    
    
    
    @IBAction func unwindFromSignup(segue : UIStoryboardSegue){
        
    }

}
