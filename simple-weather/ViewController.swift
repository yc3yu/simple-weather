//
//  ViewController.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import UIKit

class ViewController: UIViewController {

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = "Welcome to Simple Weather"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        titleLabel.backgroundColor = .gray
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        view.addSubview(titleLabel)
        titleLabel.center = self.view.center
        
//        let emptyView = ChooseLocationMethodModalView()
//        let viewModel = ChooseLocationMethodModalViewModel()
//
//        emptyView.setupLayoutConstraints()
//        emptyView.bind(viewModel: viewModel)
//        emptyView.setButtonTitles(viewModel: viewModel)
//
//        view = UIView(frame: UIScreen.main.bounds).then {
//            $0.backgroundColor = .green
//            $0.addSubview(emptyView)
//        }
        
//        let chooseLocationMethodModalViewController = ChooseLocationMethodModalViewController()
//        self.present(chooseLocationMethodModalViewController, animated: false)
    }


}

