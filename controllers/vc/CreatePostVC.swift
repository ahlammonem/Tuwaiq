//
//  CreatePostVC.swift
//  Tuwaiq
//
//  Created by ahlam on 08/01/2023.
//

import UIKit

class CreatePostVC: UIViewController {
    
    // Mark: Outletes
    @IBOutlet var postViewText: UITextView!
    
    @IBOutlet var postImg: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    



    @IBAction func backToAllPosts(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func publishBtnTapped(_ sender: Any) {
        if  postViewText.text != "",  postImg.text != "" {
     
            
            PostsApi.createPost(ownerId: UserManager.loggedInUser!.id, postText: postViewText.text!, postImg: postImg.text!) { postResonse, message in
                print("message is ",message!)
                if postResonse != nil {
                    
                    //create notification center when post created
                    NotificationCenter.default.post(name: NSNotification.Name("NotificationNewPostCreated"), object: nil)
                    self.dismiss(animated: true)
                    
                }
            }
            
        }
     
    }
    
}
