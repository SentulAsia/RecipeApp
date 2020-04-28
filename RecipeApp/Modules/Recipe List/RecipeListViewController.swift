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

    var filteredRecipeType = "" {
        didSet {
            updateFilterButton()
        }
    }

    @IBOutlet var recipeListTableView: UITableView!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Use Case

    // MARK: Filter Current Recipe

    @IBAction func filterButtonTapped(_ sender: Any) {
        if filteredRecipeType.isEmpty {
            routesToRecipeTypesPicker()
        } else {
            filteredRecipeType = ""
        }
    }

    // MARK: Add New Recipe

    @IBAction func addButtonTapped(_ sender: Any) {
        routesToAddNewRecipe()
    }
}

// MARK: - Helpers

private extension RecipeListViewController {
    func setupTableView() {
        recipeListTableView.isHidden = true
    }

    func updateFilterButton() {
        if filteredRecipeType.isEmpty {
            let button = UIBarButtonItem(title: "Filter: None", style: .plain, target: self, action: #selector(filterButtonTapped))
            self.navigationItem.setLeftBarButton(button, animated: true)
        } else {
            let button = UIBarButtonItem(title: "Filter: \(filteredRecipeType)", style: .plain, target: self, action: #selector(filterButtonTapped))
            self.navigationItem.setLeftBarButton(button, animated: true)
        }
    }
}
