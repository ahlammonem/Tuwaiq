//
//  UiView + SetViewProperties.swift
//  Tuwaiq
//
//  Created by ahlam on 27/12/2022.
//

import Foundation
import UIKit

extension UIView {

    func setCornerShadow(){
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 15)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.6
    }
    
}
