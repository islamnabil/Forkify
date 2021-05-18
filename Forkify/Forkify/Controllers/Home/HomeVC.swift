//
//  HomeVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    //MARK:- Properties
    var strategy = HomeStrategy.shared
    
    // MARK:- IBoutlets
    @IBOutlet weak var MealsRecipesTableView: UITableView!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        strategy.setStrategy(strategy: .meals, tableView: MealsRecipesTableView)
        strategy.getData()
    }
    
    //MARK:- Private Methods
    
    /// configureTableView : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        MealsRecipesTableView.delegate = self
        MealsRecipesTableView.dataSource = self
        MealsRecipesTableView.separatorStyle = .none
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
        return strategy.tableView(heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
