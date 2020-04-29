//
//  Seeds.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

extension DataStoreManager {
    /// Seed Data Store with default values
    func seeds(completion: @escaping (_ isSuccessful: Bool) -> Void) {
        var recipes: [RecipeModels.Recipe] = []

        let recipe1 = generateRecipe1()
        recipes.append(recipe1)
        let recipe2 = generateRecipe2()
        recipes.append(recipe2)

        storeToLocalDataStore(with: recipes, completion: completion)
    }

    func generateRecipe1() -> RecipeModels.Recipe {
        let recipeDictionary: [String: String] = [
            "name": "Panna Cotta",
            "type": "Dessert",
            "ingredients": "1/4 cup (60 ml) cold water or milk"
            + "\n2 1/4 teaspoons (7 g/0.25 oz.) unflavored powdered gelatin*"
            + "\n2 cups (480 ml) heavy cream"
            + "\n1/4 cup (50 g/1.8 oz.) granulated sugar"
            + "\n1/2 vanilla bean, split and seeded, or 1 teaspoon pure vanilla extract",
            "steps": "1. Place water in a small bowl and sprinkle gelatin over the surface in a single layer. Be sure not to pile it as that will prevent the crystals from dissolving properly. Let stand for 5-10 minutes to soften."
            + "\n\n2. Meanwhile, in a medium saucepan, heat cream, sugar, vanilla pod, and vanilla seeds on medium heat and bring just to a boil until sugar dissolves. Remove from heat and discard vanilla bean. Stir in gelatin and immediately whisk until smooth and dissolved. If the gelatin hasn’t fully dissolved, return the saucepan to the stove and heat gently over low heat. Stir constantly and don’t let the mixture boil."
            + "\n\n3. Pour cream into 4 individual serving dishes. Refrigerate for at least 2-4 hours, or until completely set."
            + "\n\n4. If you like, top with fresh fruit, berries, berry sauce, or lemon curd."
            + "\n\n5. Panna cotta can be covered with plastic wrap and refrigerated for up to 3 days."
        ]
        var recipe = RecipeModels.Recipe(fromDictionary: recipeDictionary)
        recipe.image = #imageLiteral(resourceName: "panna-cotta")
        return recipe
    }

    func generateRecipe2() -> RecipeModels.Recipe {
        let recipeDictionary: [String: String] = [
            "name": "Home Made Pizza",
            "type": "Main Course",
            "ingredients": "1 1/2 cups (355 ml) warm water (105°F-115°F)"
            + "\n1 package (2 1/4 teaspoons) of active dry yeast"
            + "\n3 3/4 cups (490 g) bread flour"
            + "\n2 tablespoons extra virgin olive oil (omit if cooking pizza in a wood-fired pizza oven)"
            + "\n2 teaspoons salt"
            + "\n1 teaspoon sugar",
            "steps": "1. Make and knead the pizza dough: Using the mixing paddle attachment, mix in the flour, salt, sugar, and olive oil on low speed for a minute. Then replace the mixing paddle with the dough hook attachment."
            + "\n\n2. Knead the pizza dough on low to medium speed using the dough hook about 7-10 minutes."
            + "\n\n3. If you don't have a mixer, you can mix the ingredients together and knead them by hand."
            + "\n\n4. The dough should be a little sticky, or tacky to the touch. If it's too wet, sprinkle in a little more flour."
            + "\n\n5. Let the dough rise: Spread a thin layer of olive oil over the inside of a large bowl. Place the pizza dough in the bowl and turn it around so that it gets coated with the oil."
            + "\n\n6. At this point you can choose how long you want the dough to ferment and rise. A slow fermentation (24 hours in the fridge) will result in more complex flavors in the dough. A quick fermentation (1 1/2 hours in a warm place) will allow the dough to rise sufficiently to work with."
            + "\n\n7. Cover the dough with plastic wrap."
        ]
        var recipe = RecipeModels.Recipe(fromDictionary: recipeDictionary)
        recipe.image = #imageLiteral(resourceName: "homemade-pizza")
        return recipe
    }
}

// MARK: - Helpers

private extension DataStoreManager {
    func storeToLocalDataStore(with recipes: [RecipeModels.Recipe], completion: @escaping (_ isSuccessful: Bool) -> Void) {
        for recipe in recipes {
            let request = AddNewRecipeWorker.StoreDataStoreModels.Request(recipe: recipe)
            addNewRecipeWorker.storeToLocalDataStore(with: request) { (viewModel) in
                if recipe.name == recipes.last?.name {
                    completion(viewModel.isSuccessful)
                }
            }
        }
    }
}
