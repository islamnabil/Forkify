//
//  IngredientTableCell.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import UIKit

class IngredientTableCell: UITableViewCell {

    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(ingredient:String) {
        ingredientLabel.text = " - \(ingredient)"
    }
    
}
