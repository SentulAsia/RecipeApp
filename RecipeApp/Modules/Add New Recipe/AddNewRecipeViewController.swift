//
//  AddNewRecipeViewController.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class AddNewRecipeViewController: UIViewController {

    // MARK: - Properties

    static let identifier = "AddNewRecipeViewController"
    
    @IBOutlet var newRecipeFormTableView: UITableView!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Methods

    static func loadFromNib() -> AddNewRecipeViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: AddNewRecipeViewController.identifier) as! AddNewRecipeViewController
        return viewController
    }
}

// MARK: - Helpers

private extension AddNewRecipeViewController {
    func setupTableView() {
        newRecipeFormTableView.isHidden = true
    }
}
