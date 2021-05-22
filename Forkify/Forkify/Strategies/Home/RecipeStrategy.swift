//
//  RecipeStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit
import PKHUD

class RecipeStrategy: HomeListStrategyProtocol, RecipeDetailsRoute {
  
    // MARK:- Properties
    var view:UIView
    var tableView: UITableView
    var tableHeaderTitle: String
    var tableCellHeight: CGFloat = 120
    
    /// recipes to be displayed in tableView
    var recipes = RecipesModel()
    
    /// Access HomeAPI
    let api:HomeAPIProtocol = HomeAPI()
    
    // Chosen meal to display its recipes
    var meal:String
    
    // MARK:- View LifeCycle
    init(meal:String, view:UIView, tableView:UITableView, headerTitle:String) {
        self.meal = meal
        self.view = view
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "RecipeTableCell", bundle: nil), forCellReuseIdentifier: "RecipeTableCell")
        self.tableHeaderTitle = headerTitle
    }
    
    
    func tableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeTableCell.self),for: indexPath) as! RecipeTableCell
        cell.configureView(recipe: recipes.recipes?[indexPath.row] ?? RecipeModel())
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        /// Open recipe details ViewCotroller with chosen meal's recipe
        openRecipeDetails(recipeId: recipes.recipes?[indexPath.row].recipe_id ?? "", pushFromViewController: tableView.findViewController() ?? UIViewController())
    }
    
    func numberOfRows() -> Int {
        return recipes.recipes?.count ?? 0
    }
    
    /// get recipes data of chosen `meal` from HTTP request.
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
