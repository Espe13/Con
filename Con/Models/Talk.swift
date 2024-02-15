//
//  Talk.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import Foundation

struct Talk: Codable, Identifiable {
    var id: String
    var title: String
    var name: String
    var abstract: String
    var start: Date
    var end: Date
    var imageURL: String
}
