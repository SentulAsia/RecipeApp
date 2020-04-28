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

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Methods

    static func loadFromNib() -> RecipeDetailViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: RecipeDetailViewController.identifier) as! RecipeDetailViewController
        return viewController
    }
}
