//
//  RecipeDetailsVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    //MARK:- Properties
    
    /// Access HomeAPI class to call HTTP home's requests.
    private let api:HomeAPIProtocol = HomeAPI()
    
    /// The instance of `RecipeDetailsModel` to display Recipe details info.
    private lazy var recipeDetails = RecipeDetailsModel()
    
    /// The Recipe's Id
    var recipeId = String()
    
    //MARK:- IBOutlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getRecipeDetailsAPI()
    }
    
    //MARK:- IBActions
    @IBAction func visitWebsitePressed(_ sender: Any) {
        
        /// Open recipe's website link in `SFSafariViewController`
        PrivateSFSafariViewController.present(link: recipeDetails.recipe?.source_url ?? "", presentFrom: self)
        
    }
    
    //MARK:- Public Interface
    
    /// configure RecipeDetailsVC to pass data to `RecipeDetailsVC` from another `ViewController`
    ///
    /// - Parameters:
    ///   - recipeId: id of choosen recipe
    func configureView(recipeId:String) {
        self.recipeId = recipeId
    }
    
    //MARK:- Private functions
    private func setViews(){
        
        /// Set recipe Image with `RecipeDetailsModel` data.
        recipeImage.SetImage(link: recipeDetails.recipe?.image_url ?? "")
        
        /// Set recipe title label with `RecipeDetailsModel` data.
        recipeTitleLabel.text = recipeDetails.recipe?.title ?? ""
        
        /// Reload `ingredientsTableView` with ingredients in `RecipeDetailsModel`.
        ingredientsTableView.reloadData()
    }
    
    
    /// configureTableView : `dataSource`
    /// and make `separatorStyle` to be none instead of singleLine
    private func configureTableView() {
        self.ingredientsTableView.register(UINib(nibName: "IngredientTableCell", bundle: nil), forCellReuseIdentifier: "IngredientTableCell")
        ingredientsTableView.dataSource = self
        ingredientsTableView.separatorStyle = .none
    }
    
}


// MARK: - UITableView Delegate
extension RecipeDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails.recipe?.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngredientTableCell.self),for: indexPath) as! IngredientTableCell
        cell.configureView(ingredient: recipeDetails.recipe?.ingredients?[indexPath.row] ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    
}

// MARK: - APIs
extension RecipeDetailsVC {
    
    /// getRecipeDetailsAPI
    /// if `success`, then `setViews` with fetched data.
    /// if `failure`, then print `error` in terminal.
    func getRecipeDetailsAPI() {
        api.recipeDetails(recipeId: recipeId, view: self.view) { (result) in
            switch result {
            case .success(let resposse):
                self.recipeDetails = resposse
                self.setViews()
            case .failure(let error):
                print(error)
            }
        }
    }
}
