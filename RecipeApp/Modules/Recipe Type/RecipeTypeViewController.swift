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
    typealias FetchDataStoreModels = Models.FetchFromLocalDataStore

    lazy var worker = RecipeTypeWorker()
    var currentRecipeType = ""

    var recipeTypes: [Models.RecipeType] = [] {
        didSet {
            updatePickerView()
        }
    }

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
        let request = FetchDataStoreModels.Request(currentRecipeType: currentRecipeType)
        worker.fetchFromLocalDataStore(with: request) { [weak self] (viewModel) in
            self?.recipeTypes = viewModel.recipeTypes
        }
    }

    // MARK: Selected Recipe Type

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
            if !currentRecipeType.isEmpty {
                selectDefaultRowForPickerView()
            }
        }
    }

    func selectDefaultRowForPickerView() {
        var i = 0
        for recipeType in recipeTypes {
            if currentRecipeType == recipeType.name {
                recipeTypePickerView.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
    }

    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapGestureRecognized))
        tapGesture.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func backgroundTapGestureRecognized(_ sender: Any) {
        currentRecipeType = ""
        dismiss(sender)
    }

    func dismiss(_ sender: Any) {
        routesToSender()
    }
}
