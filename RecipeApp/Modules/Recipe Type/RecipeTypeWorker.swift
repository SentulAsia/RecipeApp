//
//  RecipeTypeWorker.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeTypeWorker: NSObject {

    // MARK: - Properties

    typealias Models = RecipeTypeModels
    typealias LocalDataStoreModels = Models.FetchFromLocalDataStore
    var response = LocalDataStoreModels.Response()
    var elementName = String()
    var recipeType = String()

    // MARK: - Methods

    /// Parse recipetypes.xml in the assets
    ///
    /// - Parameters:
    ///   - request: request model that contains the currently selected recipe type
    ///   - completion: completion handler with the view model that contains array of RecipeType object parsed from the XML
    func fetchFromLocalDataStore(request: LocalDataStoreModels.Request, completion: @escaping (_ viewModel: LocalDataStoreModels.ViewModel) -> Void) {
        validate(currentRecipeType: request.currentRecipeType)

        if let path = Bundle.main.url(forResource: Constants.Assets.recipeTypeXML, withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }

        let viewModel = Models.FetchFromLocalDataStore.ViewModel(recipeTypes: response.recipeTypes)
        return completion(viewModel)
    }
}

// MARK: - Helpers

private extension RecipeTypeWorker {
    /// Validate current recipe type sent by view controller
    ///
    /// - Parameter currentRecipeType: current recipe type sent by view controller
    ///
    /// - Note: Picker view will default to first element to be selected and if user didn't scroll the picker view, the delegate will never capture
    ///         the selected title in the picker view. To over come this, and empty title is added to the picker view so that user must scroll
    ///         the picker in order to select a recipe type.
    func validate(currentRecipeType: String) {
        if currentRecipeType.isEmpty {
            let type = Models.RecipeType(name: currentRecipeType)
            response.recipeTypes.append(type)
        }
    }
}

extension RecipeTypeWorker: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == Constants.Assets.elementContainer {
            recipeType = String()
        }

        self.elementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == Constants.Assets.elementContainer {
            let type = Models.RecipeType(name: recipeType)
            response.recipeTypes.append(type)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == Constants.Assets.elementNameKey {
                recipeType += data
            }
        }
    }
}
