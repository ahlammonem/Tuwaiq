//
//  UiViewController + Alert .swift
//  Tuwaiq
//
//  Created by ahlam on 30/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title : String , message : String ){
        
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert  )
        let okAction = UIAlertAction(title: "Ok", style: .default )
        alert.addAction(okAction)
        self.present(alert, animated: true )
    }
   
}

