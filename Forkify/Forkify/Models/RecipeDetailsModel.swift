//
//  RecipeDetailsModel.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import Foundation

struct RecipeDetailsModel:Codable {
    var recipe:RecipeDetailsInfoModel?
}

struct RecipeDetailsInfoModel:Codable {
    var publisher:String?
    var ingredients: [String]?
    var source_url:String?
    var recipe_id: String?
    var image_url: String?
    var publisher_url: String?
    var title:String?
}
