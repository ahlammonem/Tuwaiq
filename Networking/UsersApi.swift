//
//  UsersApi.swift
//  Tuwaiq
//
//  Created by ahlam on 30/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class UsersApi  : Api {
    
    static func getOwnerProfile (id: String, completionHandler : @escaping(owner?) -> Void) {
        let url = "\(Base_url)/user/\(id)"
        
        
        AF.request(url, headers: headers).responseJSON { response in
            let userData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let owner = try? decoder.decode(owner.self, from: userData.rawData())
                 completionHandler(owner)
            }
            catch let error {
                print(error)
            }
            
        }
    }
    
    
    static func signUpNewUser(firstName : String , lastName : String , email : String , completionHandler : @escaping (owner?, String?) -> ()) {
        
        let url = Base_url + "/user/create"
        let params = [ "firstName" : firstName ,
                       "lastName" : lastName ,
                       "email" : email
        ]
        AF.request(url,method: .post,parameters: params, encoder : JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success :
            print("regester user successfully")
                let userData = JSON(response.value)
                print(userData)
                let decoder = JSONDecoder()
                do {
                    let user = try? decoder.decode(owner.self, from: userData.rawData())
                        completionHandler(user,nil)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lasttNameError = data["lastName"].stringValue
                let errorMessage =  firstNameError + " " + lasttNameError + " " + emailError 
                print(errorMessage)
                completionHandler(nil , errorMessage )

            }
            
            
        }
            
        }
    
    
    static func signInUser(firstName : String , lastName : String , completionHandler : @escaping (owner?, String?) -> ()) {
        
        let url = Base_url + "/user"
        let params = [ "created" : "1"]
        
        AF.request(url,method: .get,parameters: params, encoder : URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success :
                let userData = JSON(response.value)
                let data = userData["data"]
                let decoder = JSONDecoder()
                do {
                    let users = try? decoder.decode([owner].self, from: data.rawData())
                    if users != nil {
                        var foundUser : owner?
                        for user in users! {
                            if user.firstName == firstName && user.lastName == lastName {
                                foundUser = user
                                completionHandler(foundUser,nil)
                                break
                        
                            }
                        
                        }
                        completionHandler(nil , "User Not Found" )

                    }
                  
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
                
    
            }
        }
            
        }
    
    static func updateUserProfile(user : owner, completionHandler : @escaping (owner?, String?) -> ()) {
        
        let url = Base_url + "/user/\(user.id)"
        print(url)

        let params : [String : Any] = [
                      "title": user.title ,
                      "picture": user.picture ,
                      "firstName": user.firstName ,
                      "lastName": user.lastName ,
                      "phone": user.phone ,
                      "gender": user.gender ,
                      "dateOfBirth": user.dateOfBirth ,
                      "location": [
                        "country" : user.location?.country ,
                        "city": user.location?.city
                        ]
        ]
        AF.request(url,method: .put,parameters: params, encoding : JSONEncoding.default ,headers: headers).validate().responseJSON { response in
            print(params)
            switch response.result {
            case .success :
                let userData = JSON(response.value)
        
                let decoder = JSONDecoder()
                do {
                    let user = try? decoder.decode(owner.self, from: userData.rawData())
                    if user != nil {
                        print(user)
                       completionHandler(user! , "your profile udated successfully" )
                    }
                  
                }
                catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil , error.localizedDescription)

                }
            case .failure(let error):
                print(error)
                completionHandler(nil , error.localizedDescription)

            }
        }
            
        }

    
}
