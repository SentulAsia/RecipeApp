//
//  RecipeListModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum RecipeListModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
            var recipeList: [RecipeModels.Recipe] = []
        }

        struct ViewModel {
            var recipeList: [RecipeModels.Recipe] = []
        }
    }

    enum FilterRecipeList {
        struct Request {
            var recipeList: [RecipeModels.Recipe] = []
            var filter: String
        }

        struct Response {
            var recipeList: [RecipeModels.Recipe] = []
        }

        struct ViewModel {
            var filteredRecipeList: [RecipeModels.Recipe] = []
        }
    }
}
