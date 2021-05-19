//
//  RecipeTableCell.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit
import SDWebImage

class RecipeTableCell: UITableViewCell {

    // MARK:- IBoutlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipePublisherNameLabel: UILabel!
    
    // MARK:- Configure View
    func configureView(recipe:RecipeModel) {
        recipeImage.SetImage(link: recipe.image_url ?? "")
        recipeTitleLabel.text = recipe.title ?? ""
        recipePublisherNameLabel.text = recipe.publisher ?? ""
    }

}
