//
//  RoutingProtocols.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import UIKit

extension UIViewController  {
    static func instantiateViewController(viewCotroller: VCs) -> UIViewController
    {
        let vc = UIStoryboard(name: viewCotroller.storyboard, bundle: nil).instantiateViewController(withIdentifier: viewCotroller.rawValue)
        return vc
    }
    
}


protocol RecipeDetailsRoute {
//    func openRecipeDetails(for recipeId: String)
}

extension RecipeDetailsRoute {
    func openRecipeDetails(recipeId: String) -> UIViewController {
        let vc = RecipeDetailsVC.instantiateViewController(viewCotroller: .RecipeDetailsVC) as! RecipeDetailsVC
        vc.configureView(recipeId: recipeId)
       return vc
    }
}
