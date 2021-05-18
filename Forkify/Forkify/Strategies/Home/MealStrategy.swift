//
//  QueriesStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

class MealStrategy: HomeListStrategyProtocol {
    
    var tableView: UITableView
    var tableCellHeight: CGFloat = 50
    var meals = [String]()
    
    init(tableView:UITableView) {
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "MealTableCell", bundle: nil), forCellReuseIdentifier: "MealTableCell")
    }
    
    
    func tableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MealTableCell.self),for: indexPath) as! MealTableCell
        cell.configureView(name: meals[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfRows() -> Int {
        return meals.count
    }
    
    
    func getData() {
        meals = HTMLParser(link: "https://forkify-api.herokuapp.com/phrases.html", path: "/body/div/ul").parse()
        tableView.reloadData()
    }

    
}
