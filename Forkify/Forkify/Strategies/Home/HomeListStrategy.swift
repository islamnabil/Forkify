//
//  HomeListStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

 protocol HomeListStrategyProtocol {
    var tableView:UITableView {get}
    var tableHeaderTitle:String {get}
    var tableCellHeight:CGFloat {get}
    var view:UIView {get}
    func tableView(cellForRowAt indexPath:IndexPath) -> UITableViewCell
    func tableView(didSelectRowAt indexPath: IndexPath)
    func numberOfRows() -> Int
    func getData()
}


enum HomeListStrategiesType {
    case meals
    case recipes
}



class HomeStrategyManager {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = HomeStrategyManager()
    
    var strategy:HomeListStrategyProtocol?
    var view = UIView()
    var tableView = UITableView()

    func setStrategy(view:UIView, strategy:HomeListStrategiesType, tableView:UITableView, meal:String = "", searchText:String = "") {
        switch strategy {
        case .meals:
            self.strategy = MealStrategy(view: view, tableView: tableView, headerTitle: "Meals")
        case .recipes:
            self.strategy = RecipeStrategy(meal: meal, view: view, tableView: tableView, headerTitle: "Recipes")
        }
        self.strategy?.getData()
        self.view = view
        self.tableView = tableView
    }
    
     func numberOfRows() -> Int {
        return strategy?.numberOfRows() ?? 0
    }
    
    func tableViewCell(cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        return strategy?.tableView(cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableViewCellHeight() -> CGFloat {
        return strategy?.tableCellHeight ?? 0.0
    }
    
    func tableView(didSelectRowAt indexPath:IndexPath){
        strategy?.tableView(didSelectRowAt: indexPath)
    }
    
    func getData(){
        strategy?.getData()
    }
    
    func searchMeals(searchText:String){
        if let mealsStrategy = strategy as? MealStrategy {
            mealsStrategy.tableHeaderTitle = "Meals"
            mealsStrategy.getData()
            mealsStrategy.searchMeals(searchText: searchText)
        }
    }
    
    func getSearchSuggestions() {
        self.strategy = MealStrategy(view: view, tableView: tableView, headerTitle: "Recent Meals Search")
        if let mealsStrategy = strategy as? MealStrategy {
            mealsStrategy.getLastSearches()
        }
    }
    
    func getHeaderTitle() -> String {
        return strategy?.tableHeaderTitle ?? ""
    }
    
}


