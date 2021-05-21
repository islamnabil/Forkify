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
        
    }
    
    //MARK:- Public Methods
    func configureView(recipeId:String) {
        self.recipeId = recipeId
    }
    
    //MARK:- Private Methods
    private func setViews(){
        recipeImage.SetImage(link: recipeDetails.recipe?.image_url ?? "")
        recipeTitleLabel.text = recipeDetails.recipe?.title ?? ""
        ingredientsTableView.reloadData()
    }
    
    /// configureTableView : `delegate`, `dataSource`
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

// MARK: - APIs
extension RecipeDetailsVC {
    func getRecipeDetailsAPI() {
        print(recipeId)
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
