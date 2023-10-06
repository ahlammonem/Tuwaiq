//
//  PostDetailsVC.swift
//  Tuwaiq
//
//  Created by ahlam on 24/12/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView


class PostDetailsVC: UIViewController {
    
    @IBOutlet var addCommentSV: UIStackView!
    // Mark : view outlets
    
    @IBOutlet var allCommentsLbl: UILabel!
    @IBOutlet var commentTF: UITextField!
    @IBOutlet var commentsTV: UITableView!
    
    @IBOutlet var userImg: UIImageView! {
        didSet{
            userImg.setImageToCircle()
            userImg.setGreenBorder()
        }
    }
    
    
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var likesLbl: UILabel!
    @IBOutlet var postTextLbl: UILabel!
    @IBOutlet var postImg: UIImageView!
    
    var post : Post!
    var comments : [Comment] = []
    var comment : String? = nil
   // var user : owner?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.loggedInUser == nil {
            addCommentSV.isHidden = true

        }
        else {
            addCommentSV.isHidden = false

        }
        commentsTV.delegate = self
        commentsTV.dataSource = self
        
        commentsTV.register(UINib(nibName: "CommentTVCell", bundle: nil), forCellReuseIdentifier: "CommentTVCell")
        
        userNameLbl.text = post.owner.firstName + "" + post.owner.lastName
        likesLbl.text = String(post.likes)
        postTextLbl.text = post.text
        postImg.setImageFromString(imageString: post.image) { error in
            if error != nil {
                self.userImg.image = UIImage(named: "no-image")
            }
        }
        userImg.setImageFromString(imageString: post.owner.picture!) { error in
            if error != nil {
                self.userImg.image = UIImage(named: "no_person")
            }
        }
      
        getAllComments()
        
    }
    
    

    
    @IBAction func closeBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func sendCommentClicked(_ sender: Any) {
        //print(user)
        comment = commentTF.text
        if comment != "" {
           
            if let userId = UserManager.loggedInUser?.id {

                 PostsApi.addComment(ownerId: userId, postId: post.id, message:comment!)
                   getAllComments()
                    commentTF.text = ""
                   getAllComments()
                }
            
          //  print(comment!)
        
           
        }
        
    }
    
}
    extension PostDetailsVC : UITableViewDelegate , UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return comments.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVCell", for: indexPath) as! CommentTVCell
            
            let comment = comments[indexPath.row]
            cell.commentLbl.text = comment.message
            cell.userNameLbl.text = comment.owner.firstName
            if let picture = comment.owner.picture {
                cell.userImg.setImageFromString(imageString: picture) { error in
                    if error != nil {
                        self.userImg.image = UIImage(named: "no_person")
                    }
                }
            }
         
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return tableView.frame.height / 4
        }
        
        func getAllComments() {
            PostsApi.getPostComments(id: post.id) { comments in
                self.comments = comments
                self.commentsTV.reloadData()
                if comments.count == 0 {
                    self.allCommentsLbl.text = "No Comments Yet"
                }
                else {
                    self.allCommentsLbl.text = "All Comments"

                }
                
            
            }
        }
        
    }



