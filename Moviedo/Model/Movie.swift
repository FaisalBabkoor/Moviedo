//
//  Movie.swift
//  Moviedo
//
//  Created by Faisal Babkoor on 4/23/21.
//

import Foundation

struct Movie1 {
    let name: String
    let rate: Double
    let image: String
    let types: [Type]
}

enum Type: String {
    case Animation
    case  Adventure
    case Comedy
    case Horror
    case Thriller
    case Biography
    case Drama
    case Action
}

