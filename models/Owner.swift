//
//  Owner.swift
//  Tuwaiq
//
//  Created by ahlam on 24/12/2022.
//

import Foundation

struct owner : Decodable {
    
    var id : String
    var title : String?
    var firstName : String
    var lastName : String
    var picture : String?
    var gender : String?
    var email : String?
    var phone : String?
    var dateOfBirth : String?
    var location : Location?
}



