//
//  HomeListStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

// MARK:-  HomeListStrategyProtocol

/// HomeList strategy protocol to implements strategies for `HomeVC` UITableView
 protocol HomeListStrategyProtocol {
    
    /// tableView displayed in `HomeVC`
    var tableView:UITableView {get}
    
    /// The title of UITableView
    var tableHeaderTitle:String {get}
    
    /// The cell height of UITableView
    var tableCellHeight:CGFloat {get}
    
    /// The root view of UIViewController to show HUDs
    var view:UIView {get}
    
    /// The tableView function to return `UITableViewCell`
    /// in `cellForRowAt` UITableView delegate function
    func tableView(cellForRowAt indexPath:IndexPath) -> UITableViewCell
    
    /// The tableView function to implement it in `didSelectRowAt` UITableView delegate function
    func tableView(didSelectRowAt indexPath: IndexPath)
    
    /// The tableView function to return `numberOfRows` in UITableView delegate function
    func numberOfRows() -> Int
    
    /// Get data depending on strategy implementaion
    func getData()
}

// MARK:-  HomeListStrategiesType

/// Types of `HomeVC` startegies
enum HomeListStrategiesType {
    case meals
    case recipes
}



// MARK:-  HomeStrategyManager

/// Home startegy manager to instantiate startegies instances to `HomeVC` UIViewController
class HomeStrategyManager {
    
    /// Singleton
    private init(){}
    
    /// Access the singleton instance
    static var shared = HomeStrategyManager()
    
    /// Instance of implemented strategy
    var strategy:HomeListStrategyProtocol?
    
    /// The root view of UIViewController to show HUDs
    var view = UIView()
    
    /// tableView displayed in `HomeVC`
    var tableView = UITableView()

    
    /// Set current startegy of `HomeStrategyManager`,
    /// then `getData` of the strategy and set `view`, `tableView` of `HomeVC`
    ///
    /// - Parameters:
    ///   - view:Root view of UIViewController to show HUDs.
    ///   - strategy: Startegy type to be implemented.
    ///   - tableView: TableView displayed in `HomeVC`
    ///   - meal (Optional): The selected meal to display its recipes in `tableView`
    ///     (used in `RecipeStrategy` case).
    ///   - searchText (Optional): The text of `searchBar` to search meals and display in `tableView`
    ///     (used in `MealStrategy` case).
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
    
    
    /// The tableView function to return `numberOfRows` in UITableView delegate function
     func numberOfRows() -> Int {
        return strategy?.numberOfRows() ?? 0
    }
    
    
    /// The tableView function to return `UITableViewCell`
    /// in `cellForRowAt` UITableView delegate function
    func tableViewCell(cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        return strategy?.tableView(cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    
    /// The cell height of UITableView
    func tableViewCellHeight() -> CGFloat {
        return strategy?.tableCellHeight ?? 0.0
    }
    
    
    /// The tableView function to implement it in `didSelectRowAt` UITableView delegate function
    func tableView(didSelectRowAt indexPath:IndexPath){
        strategy?.tableView(didSelectRowAt: indexPath)
    }
    
    /// Get data depending on strategy implementaion
    func getData(){
        strategy?.getData()
    }
    
    /// Search Meals (used in `MealStrategy` case)
    ///  set tableView header title and
    /// `getData` from HTTP request or from cached data to search
    func searchMeals(searchText:String){
        if let mealsStrategy = strategy as? MealStrategy {
            mealsStrategy.tableHeaderTitle = "Meals"
            mealsStrategy.getData()
            mealsStrategy.searchMeals(searchText: searchText)
        }
    }
    
    /// get last meals search (used in `MealStrategy` case)
    ///  set tableView header title and
    ///  get the data from `CoreDataManager`
    func getSearchSuggestions() {
        self.strategy = MealStrategy(view: view, tableView: tableView, headerTitle: "Recent Meals Search")
        if let mealsStrategy = strategy as? MealStrategy {
            mealsStrategy.getLastSearches()
        }
    }
    
    /// get header title of TableView header
    func getHeaderTitle() -> String {
        return strategy?.tableHeaderTitle ?? ""
    }
    
}


