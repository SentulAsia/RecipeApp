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

    typealias Models = AddNewRecipeModels

    lazy var worker = AddNewRecipeWorker()
    lazy var imagePicker = ImagePicker(for: self)

    var textFieldTypes: Models.TextFieldTypes?
    var textToEdit: String?
    var editedText: String? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var nameTitleLabel: UILabel!
    @IBOutlet var nameContentLabel: UILabel!
    @IBOutlet var typeTitleLabel: UILabel!
    @IBOutlet var typeContentLabel: UILabel!
    @IBOutlet var ingredientsTitleLabel: UILabel!
    @IBOutlet var ingredientsContentLabel: UILabel!
    @IBOutlet var stepsTitleLabel: UILabel!
    @IBOutlet var stepsContentLabel: UILabel!
    @IBOutlet var editImageButton: UIButton!
    @IBOutlet var editNameButton: UIButton!
    @IBOutlet var editTypeButton: UIButton!
    @IBOutlet var editIngredientsButton: UIButton!
    @IBOutlet var editStepsButton: UIButton!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupButtons()
    }

    // MARK: - Methods

    static func loadFromNib() -> AddNewRecipeViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: AddNewRecipeViewController.identifier) as! AddNewRecipeViewController
        return viewController
    }

    // MARK: - Use Case

    // MARK: Cancel Add New Recipe

    @objc func cancelButtonTapped(_ sender: Any) {
        dismiss(sender)
    }

    // MARK: Perform Add New Recipe

    @objc func doneButtonTapped(_ sender: Any) {
        let recipe = RecipeModels.Recipe(
            type: typeContentLabel.text ?? "",
            name: nameContentLabel.text ?? "",
            ingredients: ingredientsContentLabel.text ?? "",
            steps: stepsContentLabel.text ?? "",
            image: recipeImageView.image ?? #imageLiteral(resourceName: "placeholder")
        )
        let request = AddNewRecipeWorker.StoreDataStoreModels.Request(recipe: recipe)
        worker.storeToLocalDataStore(with: request) { [weak self] (viewModel) in
            self?.dismiss(sender)
        }
    }

    // MARK: Edit Image

    @IBAction func editImageButtonTapped(_ sender: Any) {
        showPhotoLibrary()
    }

    // MARK: Edit Name

    @IBAction func editNameButtonTapped(_ sender: Any) {
        textToEdit = nameContentLabel.text
        textFieldTypes = .name
        routesToTextPicker()
    }

    @IBAction func editTypeButtonTapped(_ sender: Any) {
        textToEdit = typeContentLabel.text
        textFieldTypes = .type
        routesToRecipeTypesPicker()
    }

    // MARK: Edit Ingredients

    @IBAction func editIngredientsButtonTapped(_ sender: Any) {
        textToEdit = ingredientsContentLabel.text
        textFieldTypes = .ingredients
        routesToTextPicker()
    }

    // MARK: Edit Steps

    @IBAction func editStepsButtonTapped(_ sender: Any) {
        textToEdit = stepsContentLabel.text
        textFieldTypes = .steps
        routesToTextPicker()
    }
}

// MARK: - Helpers

private extension AddNewRecipeViewController {
    func setupTexts() {
        nameTitleLabel.text = "Recipe Name:"
        nameContentLabel.text = "An Awesome recipe"
        typeTitleLabel.text = "Recipe Type:"
        typeContentLabel.text = "Main Course"
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsContentLabel.text = "An awesome ingredients for your recipe"
        stepsTitleLabel.text = "Steps:"
        stepsContentLabel.text = "Steps to create your awesome recipe"
        editImageButton.setTitle("Edit", for: .normal)
        editNameButton.setTitle("Edit", for: .normal)
        editTypeButton.setTitle("Edit", for: .normal)
        editIngredientsButton.setTitle("Edit", for: .normal)
        editStepsButton.setTitle("Edit", for: .normal)
    }

    func updateUI() {
        switch textFieldTypes {
        case .name:
            nameContentLabel.text = editedText

        case .type:
            typeContentLabel.text = editedText
            
        case .ingredients:
            ingredientsContentLabel.text = editedText

        case .steps:
            stepsContentLabel.text = editedText

        default:
            break
        }
        updateButton()
    }

    func updateButton() {
        let isImageUpdated = recipeImageView.image?.description != #imageLiteral(resourceName: "placeholder").description
        let isNameUpdated = nameContentLabel.text != "An Awesome recipe" && nameContentLabel.text != ""
        let isIngredientUpdated = ingredientsContentLabel.text != "An awesome ingredients for your recipe" && ingredientsContentLabel.text != ""
        let isStepsUpdated = stepsContentLabel.text != "Steps to create your awesome recipe" && stepsContentLabel.text != ""
        if isImageUpdated && isNameUpdated && isIngredientUpdated && isStepsUpdated {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    func setupButtons() {
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.setLeftBarButton(leftButton, animated: true)
        let rightButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func dismiss(_ sender: Any) {
        routesToSender()
    }

    func showPhotoLibrary() {
        imagePicker.show { [weak self] (image) in
            self?.recipeImageView.image = image
        }
    }
}
