//
//  LoginViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

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
    
    
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "LoginVCtoTabVC", sender: Any?.self)
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func login(sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!,
                                 block:{(user, error) -> Void in
                                    if error != nil{
                                        print(error!)
                                    }
                                    else {
                                        // Everything went alright here
                                        
                                        self.displayOKAlert(title: "Success!", message:"Login successful")
                                        
                                        
                                    } })
    }
    
    @IBAction func unwindFromSignup(segue : UIStoryboardSegue){
        
    }

}
