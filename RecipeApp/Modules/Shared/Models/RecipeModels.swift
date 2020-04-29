//
//  RecipeModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum RecipeModels {

    // MARK: - Types

    struct Recipe {
        var type: String
        var name: String
        var ingredients: String
        var steps: String
        var image: UIImage

        private enum CodingKeys: String, CodingKey {
            case type
            case name
            case ingredients
            case steps
        }

        init(type: String, name: String, ingredients: String, steps: String, image: UIImage) {
            self.type = type
            self.name = name
            self.ingredients = ingredients
            self.steps = steps
            self.image = image
        }

        init(fromDictionary dictionary: [String: Any]) {
            let keys = CodingKeys.self
            self.type = dictionary[keys.type.rawValue] as? String ?? ""
            self.name = dictionary[keys.name.rawValue] as? String ?? ""
            self.ingredients = dictionary[keys.ingredients.rawValue] as? String ?? ""
            self.steps = dictionary[keys.steps.rawValue] as? String ?? ""
            self.image = #imageLiteral(resourceName: "placeholder")
        }

        var toDictionary: [String: String] {
            let keys = CodingKeys.self
            var dictionary = [String: String]()
            dictionary[keys.type.rawValue] = type
            dictionary[keys.name.rawValue] = name
            dictionary[keys.ingredients.rawValue] = ingredients
            dictionary[keys.steps.rawValue] = steps
            return dictionary
        }
    }
}
