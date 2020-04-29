//
//  ImagePicker.swift
//  RecipeApp
//
//  Created by Zaid Said on 29/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

class ImagePicker: NSObject {

    // MARK: - Properties

    var imagePickerController: UIImagePickerController
    var sender: UIViewController
    var completion: ((_ image: UIImage?) -> Void)?

    init(for sender: UIViewController) {
        self.imagePickerController = UIImagePickerController()
        self.sender = sender
        super.init()
    }

    func show(completion: ((_ image: UIImage?) -> Void)?) {
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary
        self.completion = completion

        self.sender.present(self.imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss(animated: true) { [weak self] in
            self?.completion?(nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        var image: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }

        picker.dismiss(animated: true) { [weak self] in
            self?.completion?(image)
        }
    }
}
