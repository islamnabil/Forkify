//
//  RouterConstants.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import Foundation

/// The enum of `Storyboard(s)` at the project
enum Storyboards:String {
    case Main = "Main"
}

/// The enum of `UIViewControllers` at the project
enum VCs:String {
    case HomeVC = "HomeVC"
    case RecipeDetailsVC = "RecipeDetailsVC"
}

/// The protocol to get the `storyboard` of current `UIViewController`
protocol StoryboardViewController {
    var storyboard:String {get}
}


/// `VCs` Implements `StoryboardViewController` protocol
extension VCs: StoryboardViewController {
    var storyboard: String {
        switch self {
        case .HomeVC, .RecipeDetailsVC:
            return Storyboards.Main.rawValue
        }
    }
}
