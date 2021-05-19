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
    
    func strategy(meal:String = "", view:UIView = UIView(),tableView:UITableView) -> HomeListStrategyProtocol {
        switch self {
        case .meals:
            return MealStrategy(view: view, tableView: tableView)
        case .recipes:
            return RecipeStrategy(meal: meal, view: view, tableView: tableView)
        }
    }

}



class HomeStrategy {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = HomeStrategy()
    
    var strategy:HomeListStrategyProtocol?
    
    func setStrategy(meal:String = "", view:UIView = UIView(), strategy:HomeListStrategiesType, tableView:UITableView) {
        switch strategy {
        case .meals:
            self.strategy = strategy.strategy(tableView: tableView)
        case .recipes:
            self.strategy = strategy.strategy(meal: meal, view: view, tableView: tableView)
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
    
}


