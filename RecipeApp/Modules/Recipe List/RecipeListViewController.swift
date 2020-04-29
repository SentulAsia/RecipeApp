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

    typealias Models = RecipeListModels
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore

    lazy var worker = RecipeListWorker()

    var recipeList: [RecipeModels.Recipe] = [] {
        didSet {
            updateTableView()
        }
    }

    var filteredRecipeType = "" {
        didSet {
            updateFilterButton()
            filterRecipeList()
        }
    }

    @IBOutlet var recipeListTableView: UITableView!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateFilterButton()
        fetchFromLocalDataStore()
    }

    // MARK: - Use Case

    // MARK: Fetch From Local Data Store

    func fetchFromLocalDataStore() {
        let request = FetchDataStoreModels.Request()
        worker.fetchFromLocalDataStore(with: request) { [weak self] (viewModel) in
            self?.recipeList = viewModel.recipeList
        }
    }

    // MARK: Perform Filter Recipe List

    func filterRecipeList() {
        if filteredRecipeType.isEmpty {
            fetchFromLocalDataStore()
        } else {
            let request = RecipeListWorker.FilterRecipeModels.Request(recipeList: recipeList, filter: filteredRecipeType)
            worker.filterRecipeList(with: request) { [weak self] (viewModel) in
                self?.recipeList = viewModel.filteredRecipeList
            }
        }
    }

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
        recipeListTableView.dataSource = self
        recipeListTableView.delegate = self
    }

    func updateTableView() {
        recipeListTableView.isHidden = recipeList.count == 0
        recipeListTableView.reloadData()
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
