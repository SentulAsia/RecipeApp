//
//  RecipeListWorker.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeListWorker {

    // MARK: - Properties

    typealias Models = RecipeListModels
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore
    typealias FilterRecipeModels = Models.FilterRecipeList

    var fetchFromLocalDataStoreResponse = FetchDataStoreModels.Response()

    // MARK: - Methods

    /// Fetch recipe from Data Store
    ///
    /// - Parameters:
    ///   - request: request model
    ///   - completion: completion handler with the view model that contains array of RecipeType object parsed from the XML
    ///
    /// - Note: TODO: Change to Core Data so that the implementation becomes clean.
    func fetchFromLocalDataStore(with request: FetchDataStoreModels.Request, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        fetchFromLocalDataStoreResponse.recipeList = []

        // perform migration if able
        DataStoreManager.shared.migrateSchema { (isSucessful) in
            // fetch all recipe names as they are the key used to store the recipe and images
            DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { [weak self] (rawRecipeNames) in
                guard let recipeNames = rawRecipeNames as? [String] else {
                    self?.failedFetchFromLocalDataStore(completion: completion)
                    return
                }

                // 1. Use semaphone to keep track of multiple data store handler.
                //
                // 2. Only escape once the for in loop have complete iterate.
                let semaphore = DispatchSemaphore(value: 0)

                // semaphore is going to block the main thread
                let dispatchQueue = DispatchQueue.global(qos: .background)

                dispatchQueue.async {
                    // iterate through all recipe names to get the recipe dictionary
                    for recipeName in recipeNames {

                        // fetch image as it uses a different storage
                        var recipeImageResponse: UIImage?
                        let imageKey = DataStoreManager.Keys.recipeImages + recipeName
                        DataStoreManager.shared.read(for: imageKey) { [weak self] (rawRecipeImage) in
                            guard let recipeImageData = rawRecipeImage as? Data,
                                let recipeImage = UIImage(data: recipeImageData) else {
                                    self?.failedFetchFromLocalDataStore(completion: completion)
                                    semaphore.signal()
                                    return
                            }
                            recipeImageResponse = recipeImage
                            semaphore.signal()
                        }
                        _ = semaphore.wait(timeout: .distantFuture)

                        // fetch recipe dictionary
                        let recipeKey = DataStoreManager.Keys.recipes + recipeName
                        DataStoreManager.shared.read(for: recipeKey) { [weak self] (rawRecipeData) in
                            guard let recipeData = rawRecipeData as? [String: String],
                                let recipeImage = recipeImageResponse else {
                                    self?.failedFetchFromLocalDataStore(completion: completion)
                                    semaphore.signal()
                                    return
                            }

                            // build recipe model by merging dictionary with image
                            var recipeResponse = RecipeModels.Recipe(fromDictionary: recipeData)
                            recipeResponse.image = recipeImage
                            self?.fetchFromLocalDataStoreResponse.recipeList.append(recipeResponse)
                            semaphore.signal()
                        }
                        _ = semaphore.wait(timeout: .distantFuture)
                    }

                    // once done, get back to main thread
                    DispatchQueue.main.async {
                        let viewModel = FetchDataStoreModels.ViewModel(recipeList: self?.fetchFromLocalDataStoreResponse.recipeList ?? [])
                        completion(viewModel)
                    }
                }
            }
        }
    }

    func filterRecipeList(with request: FilterRecipeModels.Request, completion: @escaping (_ viewModel: FilterRecipeModels.ViewModel) -> Void) {
        let recipeListReponse = request.recipeList.filter {
            $0.type == request.filter
        }
        let viewModel = FilterRecipeModels.ViewModel(filteredRecipeList: recipeListReponse)
        completion(viewModel)
    }
}

// MARK: - Helpers

private extension RecipeListWorker {
    func failedFetchFromLocalDataStore(completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        let viewModel = FetchDataStoreModels.ViewModel(recipeList: [])
        completion(viewModel)
    }
}
