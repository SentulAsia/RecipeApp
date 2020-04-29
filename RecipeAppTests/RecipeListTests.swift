//
//  RecipeListTests.swift
//  RecipeAppTests
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeListTests: XCTestCase {

    typealias Models = RecipeListModels
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore
    typealias FilterRecipeModels = Models.FilterRecipeList
    var sut: RecipeListWorker!

    override func setUpWithError() throws {
        DataStoreManager.shared.deleteAll()
        sut = RecipeListWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
        DataStoreManager.shared.deleteAll()
    }

    func testFetchFromLocalDataStore() throws {
        // given
        let firstElementExpectedResult = "Panna Cotta"
        let lastElementExpectedResult = "Home Made Pizza"
        let request = FetchDataStoreModels.Request()
        let expect = expectation(description: "Wait for fetchFromLocalDataStore(request:) to return")

        // when
        var firstElementActualResult: String!
        var lastElementActualResult: String!

        sut.fetchFromLocalDataStore(with: request) { (viewModel) in
            firstElementActualResult = viewModel.recipeList.first!.name
            lastElementActualResult = viewModel.recipeList.last!.name
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)

        // then
        XCTAssertEqual(firstElementExpectedResult, firstElementActualResult, "first element should be Panna Cotta")
        XCTAssertEqual(lastElementExpectedResult, lastElementActualResult, "last element should be Home Made Pizza")
    }

    func testFilterRecipeList() throws {
        // given
        let expectedResult = "Home Made Pizza"
        var recipes: [RecipeModels.Recipe] = []
        let recipe1 = DataStoreManager.shared.generateRecipe1()
        recipes.append(recipe1)
        let recipe2 = DataStoreManager.shared.generateRecipe2()
        recipes.append(recipe2)
        let request = FilterRecipeModels.Request(recipeList: recipes, filter: "Main Course")
        let expect = expectation(description: "Wait for filterRecipeList(request:) to return")

        // when
        var actualResult: String!

        sut.filterRecipeList(with: request) { (viewModel) in
            actualResult = viewModel.filteredRecipeList.first!.name
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)

        // then
        XCTAssertEqual(expectedResult, actualResult, "filtered first element should be Home Made Pizza")
    }
}
