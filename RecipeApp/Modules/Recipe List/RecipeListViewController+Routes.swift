//
//  RecipeListViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

// MARK: - Routing

extension RecipeListViewController {
    func routesToRecipeDetail(model: Models.Recipe) {
        let destinationVC = RecipeDetailViewController.loadFromNib()
        passData(to: destinationVC, with: model)
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

// MARK: - Data Passing

private extension RecipeListViewController {
    func passData(to destinationVC: RecipeDetailViewController, with model: Models.Recipe) {
        let recipe = RecipeDetailModels.Recipe(type: model.type, name: model.name, ingredients: model.ingredients, steps: model.steps, image: model.image)
        destinationVC.recipe = recipe
    }
}
