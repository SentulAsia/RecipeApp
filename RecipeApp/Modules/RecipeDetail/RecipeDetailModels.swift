//
//  RecipeDetailModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum RecipeDetailModels {

    // MARK: - Use Cases

    enum RemoveFromLocalDataStore {
        struct Request {
            var recipe: RecipeModels.Recipe
        }

        struct Response {
        }

        struct ViewModel {
            var isSuccessful = false
        }
    }
}
