//
//  HomeAPI.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

protocol HomeAPIProtocol {
    func search(meal:String,view:UIView,completion: @escaping (Result<RecipesModel, NSError>) -> Void)
    func recipeDetails(recipeId:String,view:UIView,completion: @escaping (Result<RecipeDetailsModel, NSError>) -> Void)
}

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
