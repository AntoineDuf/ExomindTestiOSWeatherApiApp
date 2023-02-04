//
//  WeatherViewModel.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import Foundation

final class WeatherViewModel {
    var updateLoadingMessage: () -> Void = {}

    private(set) var loadingMessage: String = "Nous téléchargeons les données…" {
        didSet {
            updateLoadingMessage()
        }
    }

    func launchLoading() {
        
    }
}
