//
//  RecipeDetailTests.swift
//  RecipeAppTests
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeDetailTests: XCTestCase {

    typealias Models = RecipeDetailModels
    typealias RemoveDataStoreModels = Models.RemoveFromLocalDataStore
    var sut: RecipeDetailWorker!

    override func setUpWithError() throws {
        DataStoreManager.shared.deleteAll()
        sut = RecipeDetailWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
        DataStoreManager.shared.deleteAll()
    }

    func testRemoveFromLocalDataStore() throws {
        // given
        let expectedRecipeCountResult = 1
        let recipe = DataStoreManager.shared.generateRecipe1()
        let request = RemoveDataStoreModels.Request(recipe: recipe)
        let expect = expectation(description: "Wait for storeToLocalDataStore(request:) to return")

        // when
        var isSuccessful: Bool!
        var actualRecipeCountResult: Int!

        DataStoreManager.shared.migrateSchema { [weak self] (isMigrationSuccessful) in
            self?.sut.removeFromLocalDataStore(with: request) { (viewModel) in
                isSuccessful = viewModel.isSuccessful

                DataStoreManager.shared.read(for: DataStoreManager.Keys.recipeNames) { (rawRecipeNames) in
                    let recipeNamesData = rawRecipeNames as! [String]
                    actualRecipeCountResult = recipeNamesData.count
                    expect.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 1)

        // then
        XCTAssertTrue(isSuccessful, "data storage removal should be successful")
        XCTAssertEqual(expectedRecipeCountResult, actualRecipeCountResult, "stored recipe data name should be removed")
    }
}
