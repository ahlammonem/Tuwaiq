//
//  CommentTVCell.swift
//  Tuwaiq
//
//  Created by ahlam on 25/12/2022.
//

import UIKit

class CommentTVCell: UITableViewCell {

    @IBOutlet var backView: UIView!{
        didSet {
            backView.setCornerShadow()
          
        }
    }
    @IBOutlet var commentLbl: UILabel!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userImg: UIImageView!{
        didSet{
           // userImg?.layer.cornerRadius = (userImg?.frame.size.width ?? 0.0) / 3
            userImg.setImageToCircle()
            userImg.setGreenBorder()
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
