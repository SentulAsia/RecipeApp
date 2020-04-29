//
//  RecipeDetailWorker.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeDetailWorker {

    // MARK: - Properties

    typealias Models = RecipeDetailModels
    typealias RemoveDataStoreModels = Models.RemoveFromLocalDataStore

    // MARK: - Methods

    /// Remove recipe from Data Store
    ///
    /// - Parameters:
    ///   - request: request model that contains Recipe object that will be deleted
    ///   - completion: completion handler with the view model that contains `isSuccessful` flag.
    ///
    /// - Note: TODO: Change to Core Data so that the implementation becomes clean.
    func removeFromLocalDataStore(with request: RemoveDataStoreModels.Request, completion: @escaping (_ viewModel: RemoveDataStoreModels.ViewModel) -> Void) {
        // 1. Use dispatch group to keep track of multiple data store handler.
        //
        // 2. Only escape once all data store request have been completed.
        let dispatchGroup = DispatchGroup()
        var isSuccessful = true

        dispatchGroup.enter()
        let imageKey = DataStoreManager.Keys.recipeImages + request.recipe.name
        DataStoreManager.shared.delete(for: imageKey) { (isImageRemoveSuccessful) in
            if !isImageRemoveSuccessful {
                isSuccessful = false
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        let recipeKey = DataStoreManager.Keys.recipes + request.recipe.name
        DataStoreManager.shared.delete(for: recipeKey) { (isRecipeRemoveSuccessful) in
            if !isRecipeRemoveSuccessful {
                isSuccessful = false
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { (rawRecipeNames) in
            guard let recipeNames = rawRecipeNames as? [String] else {
                dispatchGroup.leave()
                return
            }
            let removedRecipeNames = recipeNames.filter {
                $0 != request.recipe.name
            }
            DataStoreManager.shared.write(value: removedRecipeNames, for: DataStoreManager.Keys.recipeNames) { (isRecipeNamesWriteSuccessful) in
                if !isRecipeNamesWriteSuccessful {
                    isSuccessful = false
                }
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            let viewModel = RemoveDataStoreModels.ViewModel(isSuccessful: isSuccessful)
            completion(viewModel)
        }
    }
}
