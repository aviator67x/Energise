//
//  TabbarViewController.swift
//  Energise
//
//  Created by Andrew Kasilov on 28.04.2024.
//

import UIKit

final class TabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
}

// - MARK: private extension
private extension TabbarViewController {
    private func setupTabbar() {
        self.tabBar.backgroundColor = .gray

        let buttonViewController = UINavigationController(rootViewController: ButtonViewController())
        let mapViewController = UINavigationController(rootViewController: MapViewController())
        let tableViewController = UINavigationController(rootViewController: TableViewController())

        buttonViewController.tabBarItem = UITabBarItem(
            title: "Button",
            image: UIImage(systemName: "button.programmable"),
            selectedImage: UIImage(systemName: "button.programmable"))
        mapViewController.tabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map"))
        tableViewController.tabBarItem = UITabBarItem(
            title: "Table",
            image: UIImage(systemName: "tablecells"),
            selectedImage: UIImage(systemName: "tablecells"))

        self.viewControllers = [buttonViewController, mapViewController, tableViewController]
    }
}
