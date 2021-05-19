//
//  RecipeDetailsVC.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    let api:HomeAPIProtocol = HomeAPI()
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func visitWebsitePressed(_ sender: Any) {
        
    }
    
}

