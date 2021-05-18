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
    func tableView(cellForRowAt indexPath:IndexPath) -> UITableViewCell
    func tableView(didSelectRowAt indexPath: IndexPath)
    func numberOfRows() -> Int
    func getData()
}


enum HomeListStrategiesType {
    case meals

    func strategy(tableView:UITableView) -> HomeListStrategyProtocol {
        switch self {
        case .meals:
            return MealStrategy(tableView: tableView)
        }
    }

}



class HomeStrategy {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = HomeStrategy()
    
    var strategy:HomeListStrategyProtocol?
    
    func setStrategy(strategy:HomeListStrategiesType, tableView:UITableView) {
        self.strategy = strategy.strategy(tableView: tableView)
    }
    
     func numberOfRows() -> Int {
        return strategy?.numberOfRows() ?? 0
    }
    
    func tableViewCell(cellForRowAt:IndexPath) -> UITableViewCell {
        return strategy?.tableView(cellForRowAt: cellForRowAt) ?? UITableViewCell()
    }
    
    func tableView(heightForRowAt:IndexPath) -> CGFloat {
        return strategy?.tableCellHeight ?? 0.0
    }
    
    func getData() {
        strategy?.getData()
    }
    
}


