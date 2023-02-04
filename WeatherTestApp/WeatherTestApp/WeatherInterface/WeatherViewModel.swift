//
//  WeatherViewModel.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import Foundation

final class WeatherViewModel {
    private var loadingLabelTimer: Timer?
    private var indexMessage = 0

    private let loadingMessageArray = [
        "Nous téléchargeons les données…",
        "C’est presque fini…",
        "Plus que quelques secondes avant d’avoir le résultat…"
    ]

    var updateLoadingMessageHandler: () -> Void = {}
    var configureDisplayForLoadingHandler: () -> Void = {}

    private(set) var loadingMessage: String = "Nous téléchargeons les données…" {
        didSet {
            updateLoadingMessageHandler()
        }
    }

    func launchLoading() {
        loadingMessage = "Nous téléchargeons les données…"
        startProgressLabelTimer()
        configureDisplayForLoadingHandler()
    }

    private func startProgressLabelTimer() {
        loadingLabelTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }

    @objc private func updateLabel() {
        indexMessage += 1
        loadingMessage = loadingMessageArray[indexMessage]
        if indexMessage == 2 {
            indexMessage = -1
        }
    }
}
