//
//  AddNewRecipeModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum AddNewRecipeModels {

    // MARK: - Use Cases

    enum StoreToLocalDataStore {
        struct Request {
            var recipe: RecipeModels.Recipe
        }

        struct Response {
        }

        struct ViewModel {
            var isSuccessful = false
        }
    }

    // MARK: - Types

    enum TextFieldTypes {
        case name
        case type
        case ingredients
        case steps
    }
}
