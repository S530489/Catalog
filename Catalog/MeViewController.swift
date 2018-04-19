//
//  MeViewController.swift
//  Catalog
//
//  Created by student on 2/15/18.
//  Copyright © 2018 Chaithanya Manas Reddy Matta. All rights reserved.
//

import UIKit
import Parse

class MeViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userEmailTF: UITextField!
    
//    var loggedInUserArray : [User] = []
//    var loggedInUser : String = ""
    
//    func displayOKAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message:
//            message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK",
//                                      style: .default, handler: nil))
//        self.present(alert, animated: true)
//    }
    var users : [BFTask<PFUser>] = []
    func fetchItems() {
        users.append(PFUser.getCurrentUserInBackground())
        userNameTF.text = users[0].result?.username
        userEmailTF.text = users[0].result?.email
        

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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
