//
//  RecipeTypeModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum RecipeTypeModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
            var currentRecipeType: String
        }

        struct Response {
            var recipeTypes: [RecipeType] = []
        }

        struct ViewModel {
            var recipeTypes: [RecipeType] = []
        }
    }

    // MARK: - Types

    struct RecipeType {
        var name: String
    }
}
