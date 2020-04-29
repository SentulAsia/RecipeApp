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
    func routesToRecipeDetail(recipe: RecipeModels.Recipe) {
        let destinationVC = RecipeDetailViewController.loadFromNib()
        passData(to: destinationVC, recipe: recipe)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routesToAddNewRecipe() {
        let destinationVC = AddNewRecipeViewController.loadFromNib()
        let navigationVC = UINavigationController(rootViewController: destinationVC)
        self.present(navigationVC, animated: true)
    }

    func routesToRecipeTypesPicker() {
        let destinationVC = RecipeTypeViewController.loadFromNib()
        self.present(destinationVC, animated: true)
    }
}

// MARK: - Data Passing

private extension RecipeListViewController {
    func passData(to destinationVC: RecipeDetailViewController, recipe: RecipeModels.Recipe) {
        destinationVC.recipe = recipe
    }
}
