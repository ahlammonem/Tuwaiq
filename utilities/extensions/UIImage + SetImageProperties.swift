


import Foundation
import UIKit

extension UIImageView {
    
//    func setImageFromString (imageString : String){
//
//        if let imageUrl = URL(string: imageString) {
//            do {
//                if  let data = try? Data(contentsOf: imageUrl){
//                    if let image = UIImage(data: data) {
//                        self.image = image
//                }
//
//                }
////                else {
////                    self.image = UIImage(systemName: "person.fill")
////                }
//            }
//            catch let error {
//                print(error)
//            }
//
//        }
//
//
//    }
//
    
    func setImageFromString(imageString: String, completionHandler : @escaping(String?) -> ()) {
        
      if let url = URL(string: imageString ) {
          
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
            if let error = error?.localizedDescription {
                completionHandler(error)
                print("loma \(error)")

                
            }
            
         //   print( "loma \(error?.localizedDescription)")
          
          guard let imageData = data else { return
         
          }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
    
    
    func setImageToCircle() {
        self.layer.cornerRadius = self.frame.size.width / 2
       // userImg.clipsToBounds = true
      

    }
    
    func setGreenBorder(){
        
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 1
    
    }
    
    
}
