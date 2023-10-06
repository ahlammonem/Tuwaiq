//
//  AllTagsVC.swift
//  Tuwaiq
//
//  Created by ahlam on 31/12/2022.
//

import UIKit

class AllTagsVC: UIViewController {
    @IBOutlet var tagsNumberLbl: UILabel!
    @IBOutlet var tagsCollectionView: UICollectionView!
    var tags : [String?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       

        PostsApi.getAllTags { tagsResponse in
           self.tags = tagsResponse
            print(self.tags)
            self.tagsNumberLbl.text = "\(self.tags.count) Tags"
            self.tagsCollectionView.reloadData()
        }
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }
    

   

}

extension AllTagsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        cell.tagNameLbl.text = tags[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/6)
    }
    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        let postsVC = storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        postsVC.tagId = tags[indexPath.row]
       present(postsVC, animated: true)
    }
    
    
}
