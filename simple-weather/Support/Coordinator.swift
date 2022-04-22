//
//  Coordinator.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
