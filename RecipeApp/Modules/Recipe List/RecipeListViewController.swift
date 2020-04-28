//
//  RecipeListViewController.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var recipeListTableView: UITableView!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Use Case

    @IBAction func filterButtonTapped(_ sender: Any) {
        routesToRecipeTypesPicker()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        routesToAddNewRecipe()
    }
}

// MARK: - Helpers

private extension RecipeListViewController {
    func setupTableView() {
        recipeListTableView.isHidden = true
    }
}
