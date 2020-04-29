//
//  RecipeListWorker.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeListWorker: NSObject {

    // MARK: - Properties

    typealias Models = RecipeListModels
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore

    var response = FetchDataStoreModels.Response()

    // MARK: - Methods

    /// Fetch recipe from Data Store
    ///
    /// - Parameters:
    ///   - request: request model
    ///   - completion: completion handler with the view model that contains array of RecipeType object parsed from the XML
    ///
    /// - Note: TODO: Change to Core Data so that the implementation becomes clean.
    func fetchFromLocalDataStore(request: FetchDataStoreModels.Request, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        // TODO: temporarily mock data
        let recipeList = DataStoreManager.shared.seeds()
        let viewModel = FetchDataStoreModels.ViewModel(recipeList: recipeList)
        completion(viewModel)
        return

        // fetch all recipe names as they are the key used to store the recipe and images
//        DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { [weak self] (rawKeysData) in
//            guard let keysData = rawKeysData as? [String] else {
//                self?.failedFetchFromLocalDataStore(completion: completion)
//                return
//            }
//
//            // 1. Use semaphone to keep track of multiple data store handler.
//            //
//            // 2. Semaphore are used over dispatch group so that the data
//            //    would always be in sequence.
//            //
//            // 3. Only escape once the for in loop have complete iterate.
//            let semaphore = DispatchSemaphore(value: 0)
//
//            // semaphore is going to block the main thread
//            let dispatchQueue = DispatchQueue.global(qos: .background)
//
//            dispatchQueue.async {
//                // iterate through all recipe names to get the recipe dictionary
//                for recipeName in keysData {
//
//                    // fetch image as it uses a different storage
//                    var recipeImageResponse: UIImage?
//                    let imageKey = DataStoreManager.Keys.recipeImages + recipeName
//                    DataStoreManager.shared.read(for: imageKey) { [weak self] (rawRecipeImage) in
//                        guard let recipeImageData = rawRecipeImage as? Data,
//                            let recipeImage = UIImage(data: recipeImageData) else {
//                                self?.failedFetchFromLocalDataStore(completion: completion)
//                                semaphore.signal()
//                                return
//                        }
//                        recipeImageResponse = recipeImage
//                    }
//                    _ = semaphore.wait(timeout: .distantFuture)
//
//                    // fetch recipe dictionary
//                    let recipeKey = DataStoreManager.Keys.recipes + recipeName
//                    DataStoreManager.shared.read(for: recipeKey) { [weak self] (rawRecipeData) in
//                        guard let recipeData = rawKeysData as? [String: String],
//                            let recipeType = recipeData["type"],
//                            let recipeIngredients = recipeData["ingredients"],
//                            let recipeSteps = recipeData["steps"],
//                            let recipeImage = recipeImageResponse else {
//                                self?.failedFetchFromLocalDataStore(completion: completion)
//                                semaphore.signal()
//                                return
//                        }
//
//                        // build recipe model by merging dictionary with image
//                        let recipeResponse = Models.Recipe(type: recipeType, name: recipeName, ingredients: recipeIngredients, steps: recipeSteps, image: recipeImage)
//                        self?.response.recipeList.append(recipeResponse)
//                        semaphore.signal()
//                    }
//                    _ = semaphore.wait(timeout: .distantFuture)
//                }
//
//                // once done, get back to main thread
//                DispatchQueue.main.async {
//                    let viewModel = FetchDataStoreModels.ViewModel(recipeList: self?.response.recipeList ?? [])
//                    completion(viewModel)
//                }
//            }
//        }
    }
}

// MARK: - Helpers

private extension RecipeListWorker {
    func failedFetchFromLocalDataStore(completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        let viewModel = FetchDataStoreModels.ViewModel(recipeList: [])
        completion(viewModel)
    }
}
