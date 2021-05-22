//
//  HomeVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    //MARK:- Properties
    
    /// Accces to Singleton `HomeStrategyManager`
    var strategy = HomeStrategyManager.shared
    
    
    // MARK:- IBoutlets
    @IBOutlet weak var MealsRecipesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureTableView()
        
        /// Set `startegy` in `HomeStrategyManager` as `MealsStrategy` to fetch all meals data at first time.
        strategy.setStrategy(view: self.view, strategy: .meals, tableView: MealsRecipesTableView)
    }
    
    
    //MARK:- Private functions
    
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
    
    /// Force view to dismiss keyboard & make searchBar's text to be empty
    private func endEditing(){
        searchBar.text?.removeAll()
        view.endEditing(true)
    }
    
}

// MARK: - UITableView Delegate and DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    /// Set `numberOfRows` in `MealsRecipesTableView`
    ///
    /// - Returns: number of rows of current `strategy` in `HomeStrategyManager`
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strategy.numberOfRows()
    }
    
    
    /// Data source for a cell to insert in a particular location of `MealsRecipesTableView`.
    ///
    /// - Returns: UITableViewCell of current `stratgy` in `HomeStrategyManager`
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return strategy.tableViewCell(cellForRowAt: indexPath)
    }
    
    
    /// Delegate for the height to use for a row in a specified location.
    ///
    /// - Returns: UITableViewCell's height of current `strategy` in `HomeStrategyManager`
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return strategy.tableViewCellHeight()
    }
    
    
    /// Tells the delegate a row is selected.
    ///
    /// `endEditing`: Force view to dismiss keyboard & make searchBar's text to be empty,
    /// call `tableView(didSelectRowAt:)` function in `HomeStrategyManager` depending on current `strategy`
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        endEditing()
        strategy.tableView(didSelectRowAt: indexPath)
    }
    
    /// Data source for the title of the header of the specified section of the table view.
    ///
    /// set `MealsRecipesTableView` header title depends on current `strategy`'s title in `HomeStrategyManager`
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return strategy.getHeaderTitle()
    }
    
}


// MARK: - UISearchBar Delegate
extension HomeVC: UISearchBarDelegate {
    
    /// Delegate that the user changed the search text.
    ///
    /// Search for meals in `MealsStrategy` in `HomeStrategyManager`.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        strategy.searchMeals(searchText: searchText)
    }
    
    /// Delegate when the user begins editing the search text.
    ///
    /// Get last 10 meals search from `MealsStrategy` in `HomeStrategyManager`.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        strategy.getSearchSuggestions()
    }

    /// Delegate that the search button was tapped.
    ///
    /// `endEditing`: Force view to dismiss keyboard & make searchBar's text to be empty
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    
}
