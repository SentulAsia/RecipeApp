//
//  RecipeListViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

extension RecipeListViewController {
    func routesToRecipeDetail() {
        let destinationVC = RecipeDetailViewController.loadFromNib()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routesToAddNewRecipe() {
        let destinationVC = AddNewRecipeViewController.loadFromNib()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routesToRecipeTypesPicker() {
        let destinationVC = RecipeTypeViewController.loadFromNib()
        self.present(destinationVC, animated: true)
    }
}
