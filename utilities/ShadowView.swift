//
//  ShadowView.swift
//  Tuwaiq
//
//  Created by ahlam on 27/12/2022.
//

import UIKit

class ShadowView: UIView {

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
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 15)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.6
    }
    
}


