//
//  SignupViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse
class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var reenterPasswordTF: UITextField!
    
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func register(sender: AnyObject) {
        // Defining the user object
        let user = PFUser()
        user.username = nameTF.text!
        user.password = passwordTF.text!
        user.email = emailTF.text!
        user.signUpInBackground(block: {(success, error) -> Void in
            if let error = error as Error? {
                let errorString = error.localizedDescription
                // In case something went wrong, use errorString to get the error
                self.displayOKAlert(title: "Something has gone wrong", message:"\(errorString)")
            } else {
                // Everything went okay
                self.displayOKAlert(title: "Success!", message:"Registration was successful")
                let emailVerified = user["emailVerified"]
                if emailVerified != nil && (emailVerified as! Bool) == true {
                    // Everything is fine
                }
                else {
                    // The email has not been verified, so logout the user
                    PFUser.logOut()
                }
            } })
    }

    

}
