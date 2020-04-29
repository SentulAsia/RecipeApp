//
//  RecipeTypeViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

// MARK: - Routing

extension RecipeTypeViewController {
    func routesToSender() {
        self.dismiss(animated: true) { [weak self] in
            if let destinationVC = UIApplication.shared.visibleViewController as? RecipeListViewController,
                let currentRecipeType = self?.currentRecipeType,
                !currentRecipeType.isEmpty {
                destinationVC.filteredRecipeType = currentRecipeType
            } else if let destinationVC = UIApplication.shared.visibleViewController as? AddNewRecipeViewController,
                let currentRecipeType = self?.currentRecipeType,
                !currentRecipeType.isEmpty {
                destinationVC.editedText = currentRecipeType
            }
        }
    }
}
