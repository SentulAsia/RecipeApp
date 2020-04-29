//
//  AddNewRecipeViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

// MARK: - Routing

extension AddNewRecipeViewController {
    func routesToSender() {
        self.dismiss(animated: true) {
            guard let destinationVC = UIApplication.shared.visibleViewController as? RecipeListViewController  else { return }
            destinationVC.fetchFromLocalDataStore()
        }
    }

    func routesToTextPicker() {
        let destinationVC = TextPickerViewController.loadFromNib()
        passData(to: destinationVC, text: textToEdit)
        let navigationVC = UINavigationController(rootViewController: destinationVC)
        self.present(navigationVC, animated: true)
    }

    func routesToRecipeTypesPicker() {
        let destinationVC = RecipeTypeViewController.loadFromNib()
        passData(to: destinationVC, text: textToEdit)
        self.present(destinationVC, animated: true)
    }
}

// MARK: - Data Passing

private extension AddNewRecipeViewController {
    func passData(to destinationVC: TextPickerViewController, text: String?) {
        destinationVC.editableText = text ?? ""
    }

    func passData(to destinationVC: RecipeTypeViewController, text: String?) {
        destinationVC.currentRecipeType = text ?? ""
    }
}
