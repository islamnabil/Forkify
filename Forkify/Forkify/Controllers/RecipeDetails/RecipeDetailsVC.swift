//
//  RecipeDetailsVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    //MARK:- Properties
    private let api:HomeAPIProtocol = HomeAPI()
    private lazy var recipeDetails = RecipeDetailsModel()
    private lazy var recipeId = String()
    
    //MARK:- IBOutlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
   
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        getRecipeDetailsAPI()
    }
    
    //MARK:- IBActions
    @IBAction func visitWebsitePressed(_ sender: Any) {
        
    }
    
    //MARK:- Public Methods
    func configureView(recipeId:String) {
        self.recipeId = recipeId
    }
    
    //MARK:- Private Methods
    private func setViews(){
        configureTableView()
    }
    
    /// configureTableView : `delegate`, `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.separatorStyle = .none
    }
    
}


// MARK: - UITableView Delegate
extension RecipeDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngredientTableCell.self),for: indexPath) as! IngredientTableCell
        cell.configureView(ingredient: recipeDetails.ingredients?[indexPath.row] ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - APIs
extension RecipeDetailsVC {
    func getRecipeDetailsAPI() {
        api.recipeDetails(recipeId: recipeId, view: self.view) { (result) in
            switch result {
            case .success(let resposse):
                self.recipeDetails = resposse
                self.ingredientsTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
