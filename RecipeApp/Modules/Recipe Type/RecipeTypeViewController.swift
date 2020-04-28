//
//  RecipeTypeViewController.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class RecipeTypeViewController: UIViewController {

    // MARK: - Properties

    static let identifier = "RecipeTypeViewController"

    typealias Models = RecipeTypeModels
    typealias LocalDataStoreModels = Models.FetchFromLocalDataStore
    lazy var worker = RecipeTypeWorker()
    var recipeTypes: [Models.RecipeType] = [] {
        didSet {
            updatePickerView()
        }
    }
    var currentRecipeType = ""

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var recipeTypePickerView: UIPickerView!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupTapGesture()
        fetchFromLocalDataStore()
    }

    // MARK: - Methods

    static func loadFromNib() -> RecipeTypeViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: RecipeTypeViewController.identifier) as! RecipeTypeViewController
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }

    // MARK: - Use Case

    // MARK: Fetch From Local Data Store

    func fetchFromLocalDataStore() {
        let request = LocalDataStoreModels.Request(currentRecipeType: currentRecipeType)
        worker.fetchFromLocalDataStore(request: request) { [weak self] (viewModel) in
            self?.recipeTypes = viewModel.recipeTypes
        }
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(sender)
    }
}

// MARK: - Helpers

private extension RecipeTypeViewController {
    func setupPickerView() {
        recipeTypePickerView.isHidden = true
        recipeTypePickerView.dataSource = self
        recipeTypePickerView.delegate = self
    }

    func updatePickerView() {
        if recipeTypes.count > 0 {
            recipeTypePickerView.isHidden = false
            recipeTypePickerView.reloadAllComponents()
        }
    }

    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        tapGesture.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc
    func dismiss(_ sender: Any) {
        routesToSender()
    }
}
