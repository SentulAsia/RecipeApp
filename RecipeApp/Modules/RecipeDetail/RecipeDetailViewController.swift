//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties

    static let identifier = "RecipeDetailViewController"

    typealias Models = RecipeDetailModels

    lazy var worker = RecipeDetailWorker()

    var recipe: RecipeModels.Recipe?
    weak var sender: RecipeListViewController?

    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var ingredientsTitleLabel: UILabel!
    @IBOutlet var ingredientsContentLabel: UILabel!
    @IBOutlet var stepsTitleLabel: UILabel!
    @IBOutlet var stepsContentLabel: UILabel!
    @IBOutlet var deleteRecipeButton: UIButton!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    // MARK: - Methods

    static func loadFromNib() -> RecipeDetailViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: RecipeDetailViewController.identifier) as! RecipeDetailViewController
        return viewController
    }

    // MARK: - Use Case

    // MARK: Remove Recipe

    @IBAction func deleteRecipeButtonTapped(_ sender: Any) {
        guard let recipe = recipe else { return }
        let request = RecipeDetailWorker.RemoveDataStoreModels.Request(recipe: recipe)
        worker.removeFromLocalDataStore(with: request) { [weak self] (viewModel) in
            self?.routesToRecipeList()
        }
    }
}

// MARK: - Helpers

private extension RecipeDetailViewController {
    func setupTexts() {
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsContentLabel.text = nil
        stepsTitleLabel.text = "Steps:"
        stepsContentLabel.text = nil
        deleteRecipeButton.setTitle("Delete Recipe", for: .normal)
    }

    func updateUI() {
        recipeImageView.image = recipe?.image
        ingredientsContentLabel.text = recipe?.ingredients
        stepsContentLabel.text = recipe?.steps
        self.title = recipe?.name
    }
}
