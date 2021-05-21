//
//  RecipeStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit
import PKHUD

class RecipeStrategy: HomeListStrategyProtocol, RecipeDetailsRoute {
    var view:UIView
    var tableView: UITableView
    var tableCellHeight: CGFloat = 120
    var recipes = RecipesModel()
    let api:HomeAPIProtocol = HomeAPI()
    var meal:String
    
    init(meal:String, view:UIView, tableView:UITableView) {
        self.meal = meal
        self.view = view
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "RecipeTableCell", bundle: nil), forCellReuseIdentifier: "RecipeTableCell")
    }
    
    func tableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeTableCell.self),for: indexPath) as! RecipeTableCell
        cell.configureView(recipe: recipes.recipes?[indexPath.row] ?? RecipeModel())
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsVC = openRecipeDetails(recipeId: recipes.recipes?[indexPath.row].recipe_id ?? "")
        tableView.findViewController()?.navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
    
    func numberOfRows() -> Int {
        return recipes.recipes?.count ?? 0
    }
    
    func getData() {
        api.search(meal: meal, view: self.view) { (result) in
            switch result {
            case .success(let response):
                self.recipes = response 
                self.tableView.reloadData()
            case .failure(let error):
                print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        }
    }
    
    
}
