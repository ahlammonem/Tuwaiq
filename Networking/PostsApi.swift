//
//  PostsApi.swift
//  Tuwaiq
//
//  Created by ahlam on 27/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostsApi  : Api{


    static func getAllPosts (page : Int , limit : Int ,  tag : String? , userId: String?, completionHandler : @escaping ([Post] , Int) -> ()){
       
        var url = Base_url + "/post"
        
        if let userId = userId {
            
            url = Base_url + "/user/\(userId)/post"
        }

      var params = ["page" : page, "limit":limit]
      var myTag = tag
        print(myTag)
        if  myTag != nil {
            
            myTag = tag?.trimmingCharacters(in: .whitespacesAndNewlines)
            if myTag?.first == "#" {
              myTag = String(myTag!.dropFirst())
                print(myTag!)
            }
            url = Base_url + "/tag/\(myTag!)/post"

        }
        
        print(url)
        AF.request(url, parameters: params ,encoder : URLEncodedFormParameterEncoder.default ,headers : headers ).responseJSON { response in
            print(response)
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            print("total \(total)")
   
            let decoder = JSONDecoder()
            do{
                let posts = try  decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts , total)
            }
            catch let error {
              print(error)
            }
        }
    }
    
    
    static func getAllTags ( completionHandler : @escaping ([String?]) -> ()){
        
        let url = Base_url + "/tag"
       
        
        AF.request(url,headers: headers).responseJSON { response in
             
             let jsonData = JSON(response.value)
             let data = jsonData["data"]
             //print(data)
             let decoder = JSONDecoder()
             do{
                 let tags = try  decoder.decode([String?].self, from: data.rawData())
                 completionHandler(tags)
             }
             catch let error {
                 print(error)
             }
         }
     }
    
    
    
    static func getPostComments(id : String , completionHandler : @escaping([Comment])-> ()){
        
        let url = "\(Base_url)/post/\(id)/comment"

     
        AF.request(url, headers: headers).responseJSON { response in
 
        
            let josonData = JSON(response.value)
            let data = josonData["data"]
            //print(data)
            let decoder = JSONDecoder()
            do {
                let commentsData = try? decoder.decode([Comment].self, from: data.rawData())
                let comments = commentsData!
                completionHandler(comments)

            }
            catch let error {
             //   print(error)
                 }
            
        }
    }
    
    static func addComment(ownerId : String , postId : String , message : String ){
        let url = Base_url + "/comment/create"
        let params = ["owner":  ownerId , "post" : postId , "message": message ]
        AF.request(url,method: .post, parameters: params, encoder: JSONParameterEncoder.default , headers: headers ).responseJSON { response in
            switch response.result {
            case .success :
                print("success")
            case .failure(let error) :
                print(error)
                
            }
        }
    }
    
    static func createPost(ownerId : String , postText : String , postImg : String  , completionHandler : @escaping(Post?, String?) ->()){
        let url = Base_url + "/post/create"
        let params = ["owner":  ownerId , "text" : postText , "image": postImg]
        
        AF.request(url,method: .post, parameters: params, encoder: JSONParameterEncoder.default , headers: headers ).responseJSON { response in
            let josonData = JSON(response.value)
            let decoder = JSONDecoder()
            
            switch response.result {
            case .success :
                do {
                    let postData = try? decoder.decode(Post.self, from: josonData.rawData())
                        completionHandler(postData , "success")
    
                }
                catch let error {
                    completionHandler(nil , error.localizedDescription)

                     }
              
            case .failure(let error) :
                print(error)
                completionHandler(nil , error.localizedDescription)

                
            }
        }
    }


}



