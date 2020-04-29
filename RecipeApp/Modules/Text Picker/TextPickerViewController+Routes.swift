//
//  TextPickerViewController+Routes.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

// MARK: - Routing

extension TextPickerViewController {
    func routesToSender() {
        self.dismiss(animated: true) { [weak self] in
            guard let destinationVC = UIApplication.shared.visibleViewController as? AddNewRecipeViewController,
                let editableText = self?.editableText,
                !editableText.isEmpty else { return }
            destinationVC.editedText = editableText
        }
    }
}
