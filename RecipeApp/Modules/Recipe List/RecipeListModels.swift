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
            var recipeList: [Recipe] = []
        }

        struct ViewModel {
            var recipeList: [Recipe] = []
        }
    }

    // MARK: - Types

    struct Recipe {
        var type: String
        var name: String
        var ingredients: String
        var steps: String
        var image: UIImage

//        /// Make the model object persistant
//        func write() {
//            let imageData = image.pngData()
//            DataStoreManager.shared.write(value: [name: imageData], for: DataStoreManager.Keys.recipeImage)
//            DataStoreManager.shared.write(value: [name: ingredients], for: DataStoreManager.Keys.recipeIngredients)
//            DataStoreManager.shared.write(value: [name: steps], for: DataStoreManager.Keys.recipeSteps)
//            DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeKeys, completion: { (rawKeysData) in
//                if var keysData = rawKeysData as? [String] {
//                    // key already exist in Data Store, no need append a new one
//                    if !keysData.contains(self.name) {
//                        keysData.append(self.name)
//                        DataStoreManager.shared.write(value: keysData, for: DataStoreManager.Keys.recipeKeys)
//                    }
//                } else {
//                    let keysData: [String] = [self.name]
//                    DataStoreManager.shared.write(value: keysData, for: DataStoreManager.Keys.recipeKeys)
//                }
//            })
//        }
    }
}
