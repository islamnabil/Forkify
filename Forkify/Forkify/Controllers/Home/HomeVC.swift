//
//  HomeVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    //MARK:- Properties
    var strategy = HomeStrategyManager.shared
   
    
    // MARK:- IBoutlets
    @IBOutlet weak var MealsRecipesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureTableView()
        strategy.setStrategy(view: self.view, strategy: .meals, tableView: MealsRecipesTableView)
    }
    
    //MARK:- Private Methods
    
    /// configureTableView : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        MealsRecipesTableView.delegate = self
        MealsRecipesTableView.dataSource = self
        MealsRecipesTableView.separatorStyle = .none
    }
    
    private func configureSearchBar(){
        searchBar.delegate = self
    }
    
}

// MARK: - UITableView Delegate
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strategy.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return strategy.tableViewCell(cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return strategy.tableView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        strategy.tableView(didSelectRowAt: indexPath)
    }
    
}


// MARK: - UISearchBar Delegate
extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        strategy.searchMeals(searchText: searchText)
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard strategy.strategy is MealStrategy else {
            strategy.setStrategy(view: self.view, strategy: .meals, tableView: MealsRecipesTableView)
            return
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
