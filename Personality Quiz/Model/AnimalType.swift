//
//  AnimalType.swift
//  Personality Quiz
//
//  Created by Maryna Bolotska on 05/04/23.
//

enum AnimalType: String {
    case dog = "🐶"
    case cat = "🐱"
    case chiken = "🐤"
    case frog = "🐸"
    
    var definition: String {
        switch self {
        case .dog:
            return "You like to be with people"
        case .cat:
            return "You're independent"
        case .chiken:
            return "You like to have fun"
        case .frog:
            return "You like to travel"
        }
    }
}
