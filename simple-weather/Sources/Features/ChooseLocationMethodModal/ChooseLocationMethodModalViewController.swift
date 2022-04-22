//
//  ChooseLocationMethodModalViewController.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation
import UIKit

final class ChooseLocationMethodModalViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = ChooseLocationMethodModalViewModel()
    
    private let emptyView = ChooseLocationMethodModalView()
    
    weak var appCoordinator: AppCoordinator?
    
    private lazy var client: WeatherNetworkClient = .init()
    
    // MARK: View life cycle

    override func loadView() {
        view = UIView().then {
            $0.backgroundColor = .green
            $0.addSubview(emptyView)
        }
        
        emptyView.frame = view.bounds
        emptyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emptyView.bind(viewModel: viewModel)
        emptyView.setButtonTitles(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray

        // TODO: add button targets (see ArticleViewController for e.g.)
        
        client.fetch(from: WeatherRequest(latitude: 43.653225, longitude: -79.383186)) { result in
            print(result)
        }
        
        Task {
            do {
                let weather = try await client.fetch(from: WeatherRequest(latitude: 43.653225, longitude: -79.383186))
                print(weather)
            }
            catch {
                print("error fetching \(error)")
            }
        }
    }
    
}
