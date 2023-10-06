//
//  SelectLanguageVC.swift
//  Tuwaiq
//
//  Created by ahlam on 12/01/2023.
//

import UIKit

class SelectLanguageVC: UIViewController {

    @IBOutlet var languageView: ShadowView!
    @IBOutlet var selectedLanguageBtn: UIButton!
    @IBOutlet var selctLanguageImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        selctLanguageImg.setImageToCircle()
     
        languageView.layer.borderColor = UIColor.systemGreen.cgColor
        languageView.layer.borderWidth = 2
        
    }
    
    
    @IBAction func selectLanguageBtnClicked(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
