//
//  MyPostsVC.swift
//  Tuwaiq
//
//  Created by ahlam on 10/01/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class MyPostsVC: UIViewController {
    
    //Mark: Outletes
    @IBOutlet var loader :NVActivityIndicatorView!
    @IBOutlet weak var postsTV: UITableView!
    
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
    
    
    
      var postsList = [Post]()
      override func viewDidLoad() {
        super.viewDidLoad()

                
                getPosts()
                view.addSubview(createPostBtn)
                createPostBtn.addTarget(self, action: #selector(createPostBtnTapped), for: .touchUpInside)
                
                
                //observe notification center new post created
                NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("NotificationNewPostCreated"), object: nil)
                
             
                
                
                postsTV.dataSource = self
                postsTV.delegate = self
                
                postsTV.register(UINib(nibName: "PostTVCell", bundle: nil),forCellReuseIdentifier: "PostTVCell")
             
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
        if let loggedInUser = UserManager.loggedInUser {
            
            loader.startAnimating()
            PostsApi.getAllPosts(page : page , limit : limit ,tag: nil , userId: loggedInUser.id) { postsResponse,total  in
                self.total = total
                
                self.loader.stopAnimating()
                self.postsList.append(contentsOf: postsResponse)
                self.postsTV.reloadData()
            }
        }
    }
       
            
         
        
        }



        extension MyPostsVC : UITableViewDelegate , UITableViewDataSource {
            
            
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
           
      
                }
                cell.ownerImg.setImageFromString(imageString: post.owner.picture!) { error  in
    
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
            
            func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                print("indexPath" , indexPath.row)
                print("count",postsList.count )
                print(total)
                if(indexPath.row == postsList.count - 1  && postsList.count < total){
                   page = page + 1
                    getPosts()
                    print("done")
                }
            }
            
        
        }

    

  


