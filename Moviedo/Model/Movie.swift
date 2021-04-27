//
//  Movie.swift
//  Moviedo
//
//  Created by Faisal Babkoor on 4/23/21.
//

import UIKit

struct Movie1 {
    let name: String
    let rate: Double
    let image: UIImage
    let types: [Type]
}

enum Type: String, CaseIterable {
    case Animation
    case Adventure
    case Comedy
    case Horror
    case Thriller
    case Biography
    case Drama
    case Action
}

