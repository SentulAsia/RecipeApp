//
//  TextPickerViewController.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class TextPickerViewController: UIViewController {

    // MARK: - Properties

    static let identifier = "TextPickerViewController"

    var editableText = ""

    @IBOutlet var textPickerTextView: UITextView!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextView()
    }

    // MARK: - Methods

    static func loadFromNib() -> TextPickerViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: TextPickerViewController.identifier) as! TextPickerViewController
        return viewController
    }

    // MARK: Cancel Pick Text

    @objc func cancelButtonTapped(_ sender: Any) {
        editableText = ""
        dismiss(sender)
    }

    // MARK: Perform Pick Text

    @objc func doneButtonTapped(_ sender: Any) {
        editableText = textPickerTextView.text
        dismiss(sender)
    }
}

// MARK: - Helpers

private extension TextPickerViewController {
    func setupTextView() {
        textPickerTextView.text = editableText
        textPickerTextView.becomeFirstResponder()
    }

    func setupButtons() {
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.setLeftBarButton(leftButton, animated: true)
        let rightButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
    }

    func dismiss(_ sender: Any) {
        routesToSender()
    }
}
