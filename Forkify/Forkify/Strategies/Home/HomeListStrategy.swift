//
//  HomeListStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

 protocol HomeListStrategyProtocol {
    var tableView:UITableView {get}
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
    

    func setStrategy(view:UIView, strategy:HomeListStrategiesType, tableView:UITableView, meal:String = "", searchText:String = "") {
        switch strategy {
        case .meals:
            self.strategy = MealStrategy(view: view, tableView: tableView)
        case .recipes:
             self.strategy = RecipeStrategy(meal: meal, view: view, tableView: tableView)
        }
        self.strategy?.getData()
    }
    
     func numberOfRows() -> Int {
        return strategy?.numberOfRows() ?? 0
    }
    
    func tableViewCell(cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        return strategy?.tableView(cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView() -> CGFloat {
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
            mealsStrategy.searchMeals(searchText: searchText)
        }
    }
    
}


