//
//  LoginViewController.swift
//  Catalog
//
//  Created by chaithanya manas reddy on 09/03/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse
// class having functions for logging a user
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MsgLBL.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MsgLBL.isHidden = true
        LogoImageView.image  = #imageLiteral(resourceName: "loginLOGO")
        usernameTF.leftViewMode = .always
        passwordTF.leftViewMode = .always
        let imageTextView = UIImageView()
        imageTextView.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        imageTextView.image = #imageLiteral(resourceName: "username")
        usernameTF.leftView = imageTextView
        
        let imageTextViewPassword = UIImageView()
        imageTextViewPassword.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        imageTextViewPassword.image = #imageLiteral(resourceName: "password")
        passwordTF.leftView = imageTextViewPassword
    }
    
    // Action for the signup button to perform a segue to signup view controller
    @IBAction func SignUpACT(_ sender: Any) {
        self.performSegue(withIdentifier: "signup", sender: Any?.self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        usernameTF.text?.removeAll()
        passwordTF.text?.removeAll()
    }
    
    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var MsgLBL: UILabel!
    // Display alert function for the view
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "LoginVCtoTabVC", sender: Any?.self)
        }))
        self.present(alert, animated: true)
    }
    
    // Action for the login button in the login view controller
    @IBAction func login(sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: usernameTF.text!, password: passwordTF.text!,
                                 block:{(user, error) -> Void in
                                    if error != nil{
                                        print(error!)
                                        self.MsgLBL.isHidden = false
                                    }
                                    else {
                                        // Everything went alright here
                                        AppDelegate.pickerModel.userNameForEmail = self.usernameTF.text!
                                        self.displayOKAlert(title: "Success!", message:"Login successful")
                                        
                                        
                                    } })
    }
    
    // An unwind segue for the Signup view controller
    @IBAction func unwindFromSignup(segue : UIStoryboardSegue){
        
    }
    
    
    
}
