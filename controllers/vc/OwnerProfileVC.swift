//
//  OwnerProfileVC.swift
//  Tuwaiq
//
//  Created by ahlam on 25/12/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class OwnerProfileVC: UIViewController {
    @IBOutlet var backView: UIView!{
        didSet{
            backView.setCornerShadow()
        }
    }
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImg: UIImageView!{
        didSet{
            userImg.setImageToCircle()
        }
    }
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userPhone: UILabel!
    @IBOutlet var userCountry: UILabel!
    @IBOutlet var userGender: UILabel!
    var user : owner!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       udateUi()
        
        UsersApi.getOwnerProfile(id: user.id) { ownerResponse in
            self.user  = ownerResponse
            self.udateUi()
        }
        
    }
    
    func udateUi() {
        
        userName.text = user.firstName + " " + user.lastName
        if let userPicture = user.picture {
            userImg.setImageFromString(imageString:userPicture) { error in
                if error != nil {
                    self.userImg.image = UIImage(named: "no_person")
                }
            }

        }
        userEmail.text = user.email
        userGender.text = user.gender
        userPhone.text = user.phone
        if let location = user.location{
            userCountry.text = location.country + "," + location.city

        }
        userImg.setGreenBorder()
    
        
    }
}
