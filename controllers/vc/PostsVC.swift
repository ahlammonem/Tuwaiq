//
//  ViewController.swift
//  Tuwaiq
//
//  Created by ahlam on 24/12/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostsVC: UIViewController  {
    
    private let createPostBtn : UIButton = {
        
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
 var page : Int = 0
 var limit : Int = 5
 var total :  Int = 0
 
  @IBOutlet var userNameLbl: UILabel!
   
    @IBOutlet var tagNameView: ShadowView!
    @IBOutlet var loader: NVActivityIndicatorView!
 
    @IBOutlet var tagNameLbl: UILabel!
    
    @IBOutlet weak var postsTV: UITableView!
    
    var postsList = [Post]()
    var tagId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts()
        view.addSubview(createPostBtn)
        createPostBtn.addTarget(self, action: #selector(createPostBtnTapped), for: .touchUpInside)
        
        
        //observe notification center new post created
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("NotificationNewPostCreated"), object: nil)
        
       
        if tagId != nil{
            tagNameLbl.text = tagId
            tagNameView.isHidden = false
        }
        else {
            tagNameView.isHidden = true

        }
        NotificationCenter.default.addObserver(self, selector: #selector(ownerProfileDidTapped), name: NSNotification.Name("NotificationUserProfileTapped"), object: nil)
        
        postsTV.dataSource = self
        postsTV.delegate = self
        
        postsTV.register(UINib(nibName: "PostTVCell", bundle: nil),forCellReuseIdentifier: "PostTVCell")
     
        
        if UserManager.loggedInUser == nil {
            userNameLbl.isHidden = true
        }
        else {
            userNameLbl.isHidden = false
            userNameLbl.text = "Hi , \(UserManager.loggedInUser?.firstName ?? "") "

        }
         
    
        }
    
    override func viewDidAppear(_ animated: Bool) {
      
       
    }
    
    
    @objc func newPostAdded() {
        page = 0
        postsList = []
        getPosts()
    }
    
    @objc func createPostBtnTapped() {
        let createPostVC = storyboard?.instantiateViewController(withIdentifier: "CreatePostVC") as! CreatePostVC
        present(createPostVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        createPostBtn.frame = CGRect(x: view.frame.width - 80, y: view.frame.height - 155 , width: 60, height: 60)
    }
    
    func getPosts(){
        loader.startAnimating()
        PostsApi.getAllPosts(page : page , limit : limit ,tag: tagId , userId: nil) { postsResponse,total  in
            self.loader.stopAnimating()
            self.total = total
            
            
            self.postsList.append(contentsOf: postsResponse)
                self.postsTV.reloadData()
        }
    }
  
       
    @objc func ownerProfileDidTapped(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath =   postsTV.indexPath(for: cell){
                let post = self.postsList[indexPath.row]
            
                let vc = storyboard?.instantiateViewController(identifier: "OwnerProfileVC") as! OwnerProfileVC
                vc.user = post.owner
                present(vc, animated: true)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loggoutSeguae" {
            UserManager.loggedInUser = nil
        }
    }
    
    
}



extension PostsVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTVCell", for: indexPath) as! PostTVCell
        
        let post = self.postsList[indexPath.row]
        cell.owmerNameLbl.text = post.owner.firstName + "" + post.owner.lastName
        cell.postTextLbl.text = post.text
        if let tags = postsList[indexPath.row].tags {
            cell.tags = tags
        }
        cell.postImg.setImageFromString(imageString: post.image) { error in
          //  print("loma vc ",error)
//            if let error = error{
//                print("loma vc ",error)
//                cell.postImg.image = UIImage(named: "no-image")
//            }
        }
        cell.ownerImg.setImageFromString(imageString: post.owner.picture!) { error  in
//            if error != nil {
//                cell.ownerImg.image = UIImage(named: "no_person")
//            }
        }
        

      
        cell.likesLbl.text = String(post.likes)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postsTV.frame.height / 1.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = self.postsList[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "PostDetailsVC") as! PostDetailsVC
        vc.post = selectedPost
        present(vc, animated: true)
        
    }
    
 
  
    
    
    

}

