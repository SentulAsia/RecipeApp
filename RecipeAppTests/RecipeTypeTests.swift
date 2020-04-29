//
//  RecipeTypeTests.swift
//  RecipeAppTests
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeTypeTests: XCTestCase {

    typealias Models = RecipeTypeModels
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore
    var sut: RecipeTypeWorker!

    override func setUpWithError() throws {
        sut = RecipeTypeWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchFromLocalDataStoreWhenCurrentRecipeTypeIsEmpty() throws {
        // given
        let firstElementExpectedResult = ""
        let lastElementExpectedResult = "Drinks"
        let currentRecipeType = ""
        let request = FetchDataStoreModels.Request(currentRecipeType: currentRecipeType)
        let expect = expectation(description: "Wait for fetchFromLocalDataStore(request:) to return")

        // when
        var firstElementActualResult: String!
        var lastElementActualResult: String!

        sut.fetchFromLocalDataStore(with: request) { (viewModel) in
            firstElementActualResult = viewModel.recipeTypes.first!.name
            lastElementActualResult = viewModel.recipeTypes.last!.name
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.1)

        // then
        XCTAssertEqual(firstElementExpectedResult, firstElementActualResult, "first element should be Starter")
        XCTAssertEqual(lastElementExpectedResult, lastElementActualResult, "last element should be Drinks")
    }

    func testFetchFromLocalDataStoreWhenCurrentRecipeTypeIsNotEmpty() throws {
        // given
        let firstElementExpectedResult = "Starter"
        let lastElementExpectedResult = "Drinks"
        let currentRecipeType = "Dessert"
        let request = FetchDataStoreModels.Request(currentRecipeType: currentRecipeType)

        // when
        let expect = expectation(description: "Wait for fetchFromLocalDataStore(request:) to return")
        var firstElementActualResult: String!
        var lastElementActualResult: String!

        sut.fetchFromLocalDataStore(with: request) { (viewModel) in
            firstElementActualResult = viewModel.recipeTypes.first!.name
            lastElementActualResult = viewModel.recipeTypes.last!.name
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.1)

        // then
        XCTAssertEqual(firstElementExpectedResult, firstElementActualResult, "first element should be Starter")
        XCTAssertEqual(lastElementExpectedResult, lastElementActualResult, "last element should be Drinks")
    }
}
