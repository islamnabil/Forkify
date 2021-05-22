//
//  RoutingProtocols.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import UIKit

// MARK:- UIViewController's extension
extension UIViewController  {
    
    static func instantiateViewController(viewCotroller: VCs) -> UIViewController
    {
        let vc = UIStoryboard(name: viewCotroller.storyboard, bundle: nil).instantiateViewController(withIdentifier: viewCotroller.rawValue)
        return vc
    }
    
    func push(viewController:UIViewController) {
        if let nav = self.navigationController {
            nav.pushViewController(viewController, animated: true)
        }else {
            UINavigationController(rootViewController: self).pushViewController(viewController, animated: true)
        }
    }
    
}


// MARK:- RecipeDetailsRoute
protocol RecipeDetailsRoute {}

extension RecipeDetailsRoute {
    func openRecipeDetails<VC:UIViewController>(recipeId: String, pushFromViewController viewController:VC) {
        
        let recipeDetailsVC = UIViewController.instantiateViewController(viewCotroller: .RecipeDetailsVC) as! RecipeDetailsVC
        
        recipeDetailsVC.configureView(recipeId: recipeId)
        
        viewController.push(viewController: recipeDetailsVC)
    }
}
