//
//  AddNewRecipeTests.swift
//  RecipeAppTests
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import XCTest
@testable import RecipeApp

class AddNewRecipeTests: XCTestCase {

    typealias Models = AddNewRecipeModels
    typealias StoreDataStoreModels = Models.StoreToLocalDataStore
    var sut: AddNewRecipeWorker!

    override func setUpWithError() throws {
        DataStoreManager.shared.deleteAll()
        sut = AddNewRecipeWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
        DataStoreManager.shared.deleteAll()
    }

    func testStoreToLocalDataStore() throws {
        // given
        let expectedRecipeNameResult = "Panna Cotta"
        let expectedNameKeyResult = "Panna Cotta"
        let recipe = DataStoreManager.shared.generateRecipe1()
        let request = StoreDataStoreModels.Request(recipe: recipe)
        let expect = expectation(description: "Wait for storeToLocalDataStore(request:) to return")

        // when
        var actualRecipeNameResult: String!
        var actualNameKeyResult: String!
        var recipeImage: Data!
        var isSuccessful: Bool!

        sut.storeToLocalDataStore(with: request) { (viewModel) in
            isSuccessful = viewModel.isSuccessful

            let recipeKey = DataStoreManager.Keys.recipes + request.recipe.name
            DataStoreManager.shared.read(for: recipeKey) { (rawRecipeData) in
                let recipeData = rawRecipeData as! [String: String]
                actualRecipeNameResult = recipeData["name"]
                DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { (rawRecipeNames) in
                    let recipeNamesData = rawRecipeNames as! [String]
                    actualNameKeyResult = recipeNamesData.first!
                    let imageKey = DataStoreManager.Keys.recipeImages + request.recipe.name
                    DataStoreManager.shared.read(for: imageKey) { (rawRecipeImage) in
                        let recipeImageData = rawRecipeImage as! Data
                        recipeImage = recipeImageData
                    }
                    expect.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0.1)

        // then
        XCTAssertTrue(isSuccessful, "data storage should be successful")
        XCTAssertEqual(expectedRecipeNameResult, actualRecipeNameResult, "stored recipe data name should be Panna Cotta")
        XCTAssertEqual(expectedNameKeyResult, actualNameKeyResult, "stored recipe names data name should be Panna Cotta")
        XCTAssertNotNil(recipeImage, "stored recipe image should not be nil")
    }
}
