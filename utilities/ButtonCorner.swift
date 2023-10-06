//
//  ButtonCorner.swift
//  Tuwaiq
//
//  Created by ahlam on 30/12/2022.
//

import Foundation

import UIKit
import UIKit

class ButtonCorner : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpShadow()
    }
    
    
    
    func setUpShadow() {
        self.layer.cornerRadius = 8
     //   self.layer.shadowColor = UIColor.
//        self.layer.shadowOffset = CGSize(width: 0, height: 10)
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.7
        
        
    }
    
}
