//
//  QueriesStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit
import PKHUD

class MealStrategy: HomeListStrategyProtocol {
    var view: UIView
    var tableView: UITableView
    var tableCellHeight: CGFloat = 50
    var meals = [String]()
    
    init(view:UIView,tableView:UITableView) {
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "MealTableCell", bundle: nil), forCellReuseIdentifier: "MealTableCell")
        self.view = view
    }
    
    
    func tableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MealTableCell.self),for: indexPath) as! MealTableCell
        cell.configureView(name: meals[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        HomeStrategy.shared.setStrategy(meal: meals[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "", view: view, strategy: .recipes, tableView: tableView)
    }
    
    func numberOfRows() -> Int {
        return meals.count
    }
    
    
    func getData() {
        HTMLParser(link: "https://forkify-api.herokuapp.com/phrases.html", path: "/body/div/ul").parse(completion: { (respose) in
            self.meals = respose
            self.tableView.reloadData()
        })
    }
    
}
