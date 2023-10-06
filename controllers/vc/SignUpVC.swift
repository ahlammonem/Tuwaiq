//
//  SignUpVC.swift
//  Tuwaiq
//
//  Created by ahlam on 30/12/2022.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var emailTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func signUpClick(_ sender: Any) {
       
        let firstName = firstNameTF.text
        let lastName = lastNameTF.text
        let email = emailTF.text
            
        
            UsersApi.signUpNewUser(firstName: firstName!, lastName: lastName!,email: email!) { userResponse, error in
                
                if error != nil {
                    self.showAlert(title: "Error", message: error!)
                }
                else {
                    
                    UserManager.loggedInUser = userResponse
                    let alert = UIAlertController(title: "Success", message:"Your account created successfully", preferredStyle: .alert  )
                    let okAction = UIAlertAction(title: "Ok", style: .default) { action  in
                        let MainNavVC = self.storyboard?.instantiateViewController(withIdentifier: "MainNavVC")
                        self.present(MainNavVC!, animated: true)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true )

                 
                  
                 }
                       
                    }
                
         
            
         
        }
            
           
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
        

   
}
