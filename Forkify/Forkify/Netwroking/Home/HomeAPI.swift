//
//  HomeAPI.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

/// The interface for classes and UIViewControllers to call Home APIs
protocol HomeAPIProtocol {
    func search(meal:String,view:UIView,completion: @escaping (Result<RecipesModel, NSError>) -> Void)
    func recipeDetails(recipeId:String,view:UIView,completion: @escaping (Result<RecipeDetailsModel, NSError>) -> Void)
}

/// `HomeAPI` inherit `BaseAPI` class with generic type "`HomeNetworking`" that implement `TargetType` protocol.
/// `HomeAPI` implement `HomeAPIProtocol` protocols.
class HomeAPI: BaseAPI<HomeNetworking>, HomeAPIProtocol  {
    func search(meal: String, view: UIView, completion: @escaping (Result<RecipesModel, NSError>) -> Void) {
        fetchData(target: .recipeSearch(q: meal), responseClass: RecipesModel.self, view: view) { (result) in
            completion(result)
        }
    }
    
    func recipeDetails(recipeId: String, view: UIView, completion: @escaping (Result<RecipeDetailsModel, NSError>) -> Void) {
        fetchData(target: .recipeDetails(rId: recipeId), responseClass: RecipeDetailsModel.self, view: view) { (result) in
            completion(result)
        }
    }
}
