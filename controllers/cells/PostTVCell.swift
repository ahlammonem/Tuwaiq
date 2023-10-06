//
//  PostTVCell.swift
//  Tuwaiq
//
//  Created by ahlam on 24/12/2022.
//

import UIKit

class PostTVCell : UITableViewCell {

    var tags : [String] = []
    @IBOutlet var tagsCollectionView : UICollectionView! {
        didSet {
            tagsCollectionView.dataSource = self
            tagsCollectionView.dataSource = self
            tagsCollectionView.register(UINib(nibName: "TagPostCell", bundle: nil), forCellWithReuseIdentifier: "TagPostCell")
        }
    }
    
    @IBOutlet var ownerSV: UIStackView!{
        didSet{
            ownerSV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOwnerSV)))
        }
    }
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postTextLbl: UILabel!
    @IBOutlet weak var owmerNameLbl: UILabel!
    @IBOutlet var likesLbl: UILabel!
    @IBOutlet weak var ownerImg: UIImageView!{
        didSet{
            ownerImg.setImageToCircle()
            ownerImg.setGreenBorder()
        
        }
    }
    @IBOutlet var backView: UIView!{
        didSet {
            backView.setCornerShadow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func didTapOwnerSV(){
       
        NotificationCenter.default.post(name: NSNotification.Name("NotificationUserProfileTapped"), object: nil, userInfo:["cell" : self] )
    }
    
}

extension PostTVCell : UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagPostCell", for: indexPath) as! TagPostCell
        
            cell.tagNameLbl.text = tags[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
    }
    
    
    
    
}


