//
//  MealsController.swift
//  Kitchen-App
//
//  Created by Nourallah on 23.05.18.
//  Copyright © 2018 Nourallah. All rights reserved.
//

import UIKit


class MealsController : UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var foodnameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unityLabel: UILabel!
    
    var meal: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        usernameLabel.text = meal?.username
        foodnameLabel.text = meal?.foodname
        nameLabel.text = meal?.name
        unityLabel.numberOfLines = (meal?.unity)!
    }

}
