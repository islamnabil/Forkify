//
//  HomeAPI.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

protocol HomeAPIProtocol {
    func search(meal:String,view:UIView,completion: @escaping (Result<RecipesModel, NSError>) -> Void)
    //func recipeDetails(recipe:String,view:UIView,completion: @escaping (Result<BaseResponse<RecipesModel>, NSError>) -> Void)
}

class HomeAPI: BaseAPI<HomeNetworking>, HomeAPIProtocol  {
    func search(meal: String, view: UIView, completion: @escaping (Result<RecipesModel, NSError>) -> Void) {
        fetchData(target: .recipeSearch(q: meal), responseClass: RecipesModel.self, view: view) { (result) in
            completion(result)
        }
    }
    
}
