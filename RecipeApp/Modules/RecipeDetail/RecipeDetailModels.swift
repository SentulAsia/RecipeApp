//
//  RecipeDetailModels.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

enum RecipeDetailModels {

    // MARK: - Types

    struct Recipe {
        var type: String
        var name: String
        var ingredients: String
        var steps: String
        var image: UIImage
    }
}
