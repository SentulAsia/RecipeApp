//
//  RecipeTypeViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

extension RecipeTypeViewController {
    func routesToSender() {
        self.dismiss(animated: true) { [weak self] in
            guard let destinationVC = UIApplication.shared.visibleViewController as? RecipeListViewController,
                let currentRecipeType = self?.currentRecipeType else { return }
            destinationVC.filteredRecipeType = currentRecipeType
        }
    }
}
