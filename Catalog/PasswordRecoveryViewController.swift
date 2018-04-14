//
//  PasswordRecoveryViewController.swift
//  Catalog
//
//  Created by Student on 4/13/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet weak var loginLogo: UIImageView!
    @IBOutlet weak var UserEmailTXT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        loginLogo.image = #imageLiteral(resourceName: "loginLOGO")
        UserEmailTXT.leftViewMode = .always
        let imageTextEmail = UIImageView()
        imageTextEmail.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        imageTextEmail.image = #imageLiteral(resourceName: "email")
        UserEmailTXT.leftView = imageTextEmail
    }
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "LoginVCtoTabVC", sender: Any?.self)
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func PasswordRecovery(_ sender: Any) {
        let userEmail = UserEmailTXT.text
        PFUser.requestPasswordResetForEmail(inBackground: userEmail!,
                        block: { (success , error) -> Void in
            if(success){
                self.displayOKAlert(title: "Success!", message: "Email was sent to you at \(userEmail!)")
                return
            }
            if(error != nil){
                self.displayOKAlert(title: "Error in Recovery", message: "Error occured")
                print("************************/n")
                print(error!)
            }
        })
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    
}

