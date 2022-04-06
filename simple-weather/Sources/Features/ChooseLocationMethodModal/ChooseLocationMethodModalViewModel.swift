//
//  ChooseLocationMethodModalViewModel.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation

struct ChooseLocationMethodModalViewModel {
    
    // MARK: Properties
    
    let titleText = NSLocalizedString("Welcome to Simple Weather", comment: "title")
    let descriptionText = NSLocalizedString("Please choose a method to set your location:", comment: "description")
    let inputCityButtonTitle = NSLocalizedString("Input a City", comment: "input city button title")
    let useMyLocationButtonTitle = NSLocalizedString("Use My Location", comment: "use my location button title")
}
