//
//  AddNewRecipeWorker.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class AddNewRecipeWorker {

    // MARK: - Properties

    typealias Models = AddNewRecipeModels
    typealias StoreDataStoreModels = Models.StoreToLocalDataStore

    // MARK: - Methods

    /// Store recipe to Data Store
    ///
    /// - Parameters:
    ///   - request: request model that contains Recipe object that will be stored
    ///   - completion: completion handler with the view model that contains `isSuccessful` flag.
    ///
    /// - Note: TODO: Change to Core Data so that the implementation becomes clean.
    func storeToLocalDataStore(with request: StoreDataStoreModels.Request, completion: @escaping (_ viewModel: StoreDataStoreModels.ViewModel) -> Void) {
        guard let imageData = request.recipe.image.pngData() else {
            failedStoreToLocalDataStore(completion: completion)
            return
        }

        // 1. Use dispatch group to keep track of multiple data store handler.
        //
        // 2. Only escape once all data store request have been completed.
        let dispatchGroup = DispatchGroup()
        var isSuccessful = true

        dispatchGroup.enter()
        let imageKey = DataStoreManager.Keys.recipeImages + request.recipe.name
        DataStoreManager.shared.write(value: imageData, for: imageKey) { (isImageWriteSuccessful) in
            if !isImageWriteSuccessful {
                isSuccessful = false
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        let recipeKey = DataStoreManager.Keys.recipes + request.recipe.name
        DataStoreManager.shared.write(value: request.recipe.toDictionary, for: recipeKey) { (isRecipeWriteSuccessful) in
            if !isRecipeWriteSuccessful {
                isSuccessful = false
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { (rawRecipeNames) in
            guard var recipeNames = rawRecipeNames as? [String] else {
                DataStoreManager.shared.write(value: [request.recipe.name], for: DataStoreManager.Keys.recipeNames) { (isRecipeNamesWriteSuccessful) in
                    if !isRecipeNamesWriteSuccessful {
                        isSuccessful = false
                    }
                }
                dispatchGroup.leave()
                return
            }
            if !recipeNames.contains(request.recipe.name) {
                recipeNames.append(request.recipe.name)
                DataStoreManager.shared.write(value: recipeNames, for: DataStoreManager.Keys.recipeNames) { (isRecipeNamesWriteSuccessful) in
                    if !isRecipeNamesWriteSuccessful {
                        isSuccessful = false
                    }
                }
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            let viewModel = StoreDataStoreModels.ViewModel(isSuccessful: isSuccessful)
            completion(viewModel)
        }
    }
}

// MARK: - Helpers

private extension AddNewRecipeWorker {
    func failedStoreToLocalDataStore(completion: @escaping (_ viewModel: StoreDataStoreModels.ViewModel) -> Void) {
        let viewModel = StoreDataStoreModels.ViewModel(isSuccessful: false)
        completion(viewModel)
    }
}
