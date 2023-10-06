//
//  EditProfileVC.swift
//  Tuwaiq
//
//  Created by ahlam on 06/01/2023.
//

import UIKit


class EditProfileVC: UIViewController

{
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var imageUrlTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var birthDAte: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var city: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveBtn.setCornerShadow()
        userImg.setImageToCircle()
        setUpUserData()
    }
    

    //Mark: get user data
    func setUpUserData(){
        if let loggedInUser = UserManager.loggedInUser {

            print(loggedInUser)
            UsersApi.getOwnerProfile(id: loggedInUser.id) { userResponse in
                print(userResponse)
                if let user = userResponse {
                    if let title = user.title {
                        self.titleTF.text = title
                    }
                    self.firstNameTF.text = user.firstName
                    self.lastNameTF.text = user.lastName
                    self.phone.text = user.phone
                    self.gender.text = user.gender
                    self.birthDAte.text = user.dateOfBirth
                    self.country.text = user.location?.country
                    self.city.text = user.location?.city
                    self.imageUrlTF.text = user.picture


        if let image = user.picture {
            self.userImg.setImageFromString(imageString: image) { error in
                if error != nil {
                    self.userImg.image = UIImage(named: "no_person")
                }
            }
        }

            
                }
     
            }
            
        }
    }
    @IBAction func saveBtnClicked(_ sender: UIButton) {
     if let loggedInUser =  UserManager.loggedInUser {
         
         var location = Location(city: city.text!, country: country.text!)
         var user = owner(id: loggedInUser.id, title: titleTF.text!, firstName: firstNameTF.text!, lastName: lastNameTF.text! , picture: imageUrlTF.text!, gender: gender.text!, phone: phone.text!, dateOfBirth : birthDAte.text!, location: location)
         
             print(user)
            UsersApi.updateUserProfile(user: user) { userResponse, message in
                if userResponse != nil{
                    self.setUpUserData()

                    NotificationCenter.default.post(name: NSNotification.Name("NotificationUserProfileUpdated"), object: nil)
                  self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func backToProfile(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
