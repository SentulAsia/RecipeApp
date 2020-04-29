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
    func seeds() -> [RecipeListModels.Recipe] {
        var recipes: [RecipeListModels.Recipe] = []

        let recipe1 = generateRecipe1()
        recipes.append(recipe1)
        let recipe2 = generateRecipe2()
        recipes.append(recipe2)

        return recipes
    }

    private func generateRecipe1() -> RecipeListModels.Recipe {
        let name = "Panna Cotta"
        let type = "Dessert"
        let image: UIImage = #imageLiteral(resourceName: "panna-cotta")
        let ingredients = "1/4 cup (60 ml) cold water or milk"
        + "\n2 1/4 teaspoons (7 g/0.25 oz.) unflavored powdered gelatin*"
        + "\n2 cups (480 ml) heavy cream"
        + "\n1/4 cup (50 g/1.8 oz.) granulated sugar"
        + "\n1/2 vanilla bean, split and seeded, or 1 teaspoon pure vanilla extract"
        let steps = "Place water in a small bowl and sprinkle gelatin over the surface in a single layer. Be sure not to pile it as that will prevent the crystals from dissolving properly. Let stand for 5-10 minutes to soften."
        + "\nMeanwhile, in a medium saucepan, heat cream, sugar, vanilla pod, and vanilla seeds on medium heat and bring just to a boil until sugar dissolves. Remove from heat and discard vanilla bean. Stir in gelatin and immediately whisk until smooth and dissolved. If the gelatin hasn’t fully dissolved, return the saucepan to the stove and heat gently over low heat. Stir constantly and don’t let the mixture boil."
        + "\nPour cream into 4 individual serving dishes. Refrigerate for at least 2-4 hours, or until completely set."
        + "\nIf you like, top with fresh fruit, berries, berry sauce, or lemon curd."
        + "\nPanna cotta can be covered with plastic wrap and refrigerated for up to 3 days."
        let recipe = RecipeListModels.Recipe(type: type, name: name, ingredients: ingredients, steps: steps, image: image)
        return recipe
    }

    private func generateRecipe2() -> RecipeListModels.Recipe {
        let name = "Home Made Pizza"
        let type = "Main Course"
        let image: UIImage = #imageLiteral(resourceName: "homemade-pizza")
        let ingredients = "1 1/2 cups (355 ml) warm water (105°F-115°F)"
        + "\n1 package (2 1/4 teaspoons) of active dry yeast"
        + "\n3 3/4 cups (490 g) bread flour"
        + "\n2 tablespoons extra virgin olive oil (omit if cooking pizza in a wood-fired pizza oven)"
        + "\n2 teaspoons salt"
        + "\n1 teaspoon sugar"
        let steps = "\nMake and knead the pizza dough: Using the mixing paddle attachment, mix in the flour, salt, sugar, and olive oil on low speed for a minute. Then replace the mixing paddle with the dough hook attachment."
        + "Knead the pizza dough on low to medium speed using the dough hook about 7-10 minutes."
        + "If you don't have a mixer, you can mix the ingredients together and knead them by hand."
        + "The dough should be a little sticky, or tacky to the touch. If it's too wet, sprinkle in a little more flour."
        + "3 Let the dough rise: Spread a thin layer of olive oil over the inside of a large bowl. Place the pizza dough in the bowl and turn it around so that it gets coated with the oil."
        + "At this point you can choose how long you want the dough to ferment and rise. A slow fermentation (24 hours in the fridge) will result in more complex flavors in the dough. A quick fermentation (1 1/2 hours in a warm place) will allow the dough to rise sufficiently to work with."
        + "Cover the dough with plastic wrap."
        let recipe = RecipeListModels.Recipe(type: type, name: name, ingredients: ingredients, steps: steps, image: image)
        return recipe
    }
}
