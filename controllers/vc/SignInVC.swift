//
//  SignInVC.swift
//  Tuwaiq
//
//  Created by ahlam on 31/12/2022.
//

import UIKit

class SignInVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet var firstNameTF: UITextField!
    
    @IBOutlet var lastNameTF: UITextField!
 

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

   
    // MARK: - Actions
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        
        let MainNavVC = self.storyboard?.instantiateViewController(withIdentifier: "MainNavVC")
   
    
        
        if firstNameTF.text != "" && lastNameTF.text != ""{
            
            UsersApi.signInUser(firstName: firstNameTF.text!, lastName: lastNameTF.text!) { user, error in
                if error != nil{
                    self.showAlert(title: "Error", message: error!)

                }
                else {
                    if let foundUser : owner = user {
                        UserManager.loggedInUser = foundUser
                       self.present(MainNavVC!, animated: true)

                    }
                  
                }
            }
        }
        else {
            showAlert(title: "Error", message: "Enter your First Name and Last Name ")
        }
      
    }
}
