//
//  Member.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import Foundation

struct Member: Codable, Identifiable {
    var id: String
    var name: String
    var role: String
    var crsid: String
    var imageURL: String
    var ranking: String
    var mail: String
    var info: String
    var link: String
}


struct SOCMember: Codable, Identifiable {
    var id: String
    var name: String
    var role: String
    var const: String
    var imageURL: String
    var ranking: String
    var mail: String
    var info: String
    var link: String
}

