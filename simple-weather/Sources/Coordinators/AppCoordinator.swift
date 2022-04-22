//
//  AppCoordinator.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let chooseLocationMethodModalViewController = ChooseLocationMethodModalViewController()
        chooseLocationMethodModalViewController.appCoordinator = self
        navigationController.pushViewController(chooseLocationMethodModalViewController, animated: false)
    }
    
}
