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
}
