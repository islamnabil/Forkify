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
    var CachedMeals = [String]()
    
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
        CoreDataManager.shared.addSearch(searchText: meals[indexPath.row])
        HomeStrategyManager.shared.setStrategy(view: view, strategy: .recipes, tableView: tableView, meal: meals[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
    
    func numberOfRows() -> Int {
        return meals.count
    }
    
    
    func getData() {
        if CachedMeals.count == 0 {
            HTMLParser(link: "https://forkify-api.herokuapp.com/phrases.html", path: "/body/div/ul").parse(completion: { (respose) in
                self.meals = respose
                self.CachedMeals = respose
                self.tableView.reloadData()
            })
        }else {
            meals = CachedMeals
            self.tableView.reloadData()
        }
    }
    
    
    func searchMeals(searchText:String){
        if !searchText.isEmpty {
            meals.removeAll()
            meals =  CachedMeals.filter({ meal in
                return meal.lowercased().hasPrefix(searchText.lowercased())
            })
            self.tableView.reloadData()
        }else {
            getData()
        }
    }
    
    func getLastSearches()  {
        meals = CoreDataManager.shared.getAllSearchHistory().reversed()
        self.tableView.reloadData()
    }
    
}
