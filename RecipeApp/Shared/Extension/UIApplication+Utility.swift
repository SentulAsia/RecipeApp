//
//  UIApplication+Utility.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import UIKit

extension UIApplication {

    /// The current visible `UIViewController`.
    var visibleViewController: UIViewController? {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let rootViewController = window?.rootViewController else {
            return nil
        }

        return getVisibleViewController(rootViewController)
    }

    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        } else if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        } else if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }

        return rootViewController
    }
}
