//
//  MyProfileVC.swift
//  Tuwaiq
//
//  Created by ahlam on 03/01/2023.
//

import UIKit

class MyProfileVC: UIViewController {

    // Mark:- Outletes
    
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var userEmailLbl: UILabel!
    @IBOutlet var userPhoneLbl: UILabel!
    @IBOutlet var userCountryLbl: UILabel!
    @IBOutlet var userGenderLbl: UILabel!
    @IBOutlet var userBirthdateLbl: UILabel!
    var updated = false
    
    // Mark: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(profileUpdated), name: NSNotification.Name("NotificationUserProfileUpdated"), object: nil)
        
        setUpUserData()
        userImg.setImageToCircle()
        

    }
    
    @objc func profileUpdated(){
        setUpUserData()

    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUserData()

    }
    override func viewDidAppear(_ animated: Bool) {
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
                        self.userNameLbl.text = title + " " +  user.firstName  + " " + user.lastName

                    }

                                if let image = user.picture {
                                    self.userImg.setImageFromString(imageString: image) { error in
                                        if error != nil {
                                            self.userImg.image = UIImage(named: "no_person")
                                        }
                                    }
                                }
                    self.userEmailLbl.text = user.email
                    self.userPhoneLbl.text = user.phone
                                if let location = user.location {
                                    self.userCountryLbl.text = location.country + "," + location.city
                                }
                    self.userGenderLbl.text = user.gender
                    
                    let dateString = "1996-07-02T00:00.000Z"

                    // Create an ISO8601DateFormatter object
                    let dateFormatter = ISO8601DateFormatter()

                    // Convert the string to a Date object
                    if let date = dateFormatter.date(from: dateString) {
                        // Create a DateFormatter object for the desired output format
                        let outputFormatter = DateFormatter()
                        outputFormatter.dateFormat = "yyyy-MM-dd"
                        
                        // Convert the date to the desired format
                        let formattedDate = outputFormatter.string(from: date)
                        self.userBirthdateLbl.text = formattedDate
                        print(formattedDate)  // Output: 1996-02-07
                    } else {
                        print("Invalid date string")
                    }
                    
                }
     
            }
            
        }
        
        
        
    }
    
    
    //yyyy-MM-ddHH:mm:ss ZZZZ
    
    
    


}
