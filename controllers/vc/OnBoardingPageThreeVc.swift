//
//  OnBoardingPageThreeVc.swift
//  Tuwaiq
//
//  Created by ahlam on 10/01/2023.
//

import UIKit

class OnBoardingPageThreeVc: UIViewController {

    @IBOutlet var getStartedBtn: UIButton!
    @IBOutlet var onBordingImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        onBordingImg.setImageToCircle()
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
