//
//  AppCoordinator.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation
import UIKit

final class AppCoordinator: NSObject, Coordinator {
    
    // MARK: Properties
    
    private let navigationController: UINavigationController
    
    var coordinatorDelegate: CoordinatorDelegate?
    
    // MARK: Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        super.init()
    }
    
    func start(animated: Bool) {
        let chooseLocationMethodModalViewController = ChooseLocationMethodModalViewController()
        
        navigationController.present(chooseLocationMethodModalViewController, animated: animated)
    }
    
}
