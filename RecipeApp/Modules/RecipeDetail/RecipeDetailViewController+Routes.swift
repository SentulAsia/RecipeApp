//
//  RecipeDetailViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

// MARK: - Routing

extension RecipeDetailViewController {
    func routesToRecipeList() {
        self.navigationController?.popToRootViewController(animated: true)
        self.sender?.filteredRecipeType = ""
    }
}
