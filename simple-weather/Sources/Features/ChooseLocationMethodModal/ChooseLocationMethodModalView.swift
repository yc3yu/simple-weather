//
//  ChooseLocationMethodModalView.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation
import UIKit
import SwiftUI

final class ChooseLocationMethodModalView: UIView {
    private enum Layout {
        static let mainStackViewInset: CGFloat = 24
    }
    
    // MARK: Properties
    
    private let mainStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let textStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let buttonStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.text = "Welcome to Simple Weather"
        $0.textColor = .white
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        $0.backgroundColor = .gray
    }
    
    private let descriptionLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        $0.backgroundColor = .gray
    }
    
    private let inputCityButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .red
    }
    
    private let useMyLocationButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .red
    }
    
    // MARK: Initialization

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(textStackView)
        mainStackView.addArrangedSubview(buttonStackView)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        
        buttonStackView.addArrangedSubview(inputCityButton)
        buttonStackView.addArrangedSubview(useMyLocationButton)
        
        setupLayoutConstraints()
    }
    
    // MARK: Public Functions
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.mainStackViewInset),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.mainStackViewInset),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.mainStackViewInset),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.mainStackViewInset),
            
            
        ])
    }
    
    func bind(viewModel: ChooseLocationMethodModalViewModel) {
//        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
    }
    
    func setButtonTitles(viewModel: ChooseLocationMethodModalViewModel) {
        inputCityButton.setTitle(viewModel.inputCityButtonTitle, for: .normal)
        useMyLocationButton.setTitle(viewModel.useMyLocationButtonTitle, for: .normal)
    }
}
