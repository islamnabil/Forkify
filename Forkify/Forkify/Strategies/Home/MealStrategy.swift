//
//  QueriesStrategy.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit
import PKHUD

class MealStrategy: HomeListStrategyProtocol {
    
    // MARK:- Properties
    var view: UIView
    var tableView: UITableView
    var tableHeaderTitle: String
    var tableCellHeight: CGFloat = 50
    
    /// meals to be displayed in tableView
    var meals = [String]()
    
    /// cachedMeals for `meals` array
    var CachedMeals = [String]()
    
    // MARK:- View LifeCycle
    init(view:UIView,tableView:UITableView, headerTitle:String) {
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "MealTableCell", bundle: nil), forCellReuseIdentifier: "MealTableCell")
        self.view = view
        self.tableHeaderTitle = headerTitle
    }
    
    // MARK:- TableView functions
    func tableView(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MealTableCell.self),for: indexPath) as! MealTableCell
        cell.configureView(name: meals[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        
        /// Save the search selection in `CoreDataManager` to display it later in search suggestions
        CoreDataManager.shared.addSearch(searchText: meals[indexPath.row])
        
        /// Set current strategy in `HomeStrategyManager` to be `RecipeStrategy`
        /// to display selected meal's recipes
        HomeStrategyManager.shared.setStrategy(view: view, strategy: .recipes, tableView: tableView, meal: meals[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
    
    
    func numberOfRows() -> Int {
        return meals.count
    }
    
    
    // MARK:- Get Data
    /// if `cachedMeals` is empty then get data from HTTP request and save it in `cachedMeals`
    /// else get data from `cachedMeals`.
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
    
    
    // MARK:- Search Meals
    /// if `searchText` isn't empy, set meals with list of the available search queries starting with
    /// this letter or group of letters
    /// else `getData` to fetch all meals
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
    
    // MARK:- Get Last Searches
    /// get last searches from `CoreDataManager` and reverse it to make it LIFO to user.
    func getLastSearches()  {
        meals = CoreDataManager.shared.getAllSearchHistory().reversed()
        self.tableView.reloadData()
    }
    
}
