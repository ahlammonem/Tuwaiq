
import Foundation
import UIKit

struct Post : Decodable {
    
    var id : String
    var image : String
    var likes : Int
    var text : String
    var owner : owner
    var tags : [String]?
}
