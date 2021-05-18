//
//  MealTableCell.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import UIKit

class MealTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:- Configure View
    func configureView(name:String) {
        nameLabel.text = name
    }
    
}
