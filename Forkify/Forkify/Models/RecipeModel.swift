//
//  RecipeModel.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation

struct RecipesModel:Codable {
    var recipes:[RecipeModel]?
}

struct RecipeModel:Codable {
    var publisher: String?
    var title: String?
    var source_url: String?
    var recipe_id: String?
    var image_url:String?
    var social_rank: Int?
    var publisher_url: String?
}
