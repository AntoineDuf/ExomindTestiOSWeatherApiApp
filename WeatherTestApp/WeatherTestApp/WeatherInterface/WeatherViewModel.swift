//
//  WeatherViewModel.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//
//MARK: What I could have done with more time in all project.
// - Add marks and comments in all project.
// - Do some refacto to emprove the lisibility.
// - Add ShiftGen to handle all string into localised strings.

//MARK: What I could have done with more time in this file.
// - Use only one Timer and handle different update with a method that determinate what to do with modulo operator.
// - Aggregate the handlers to improve lisibility.

import Foundation

final class WeatherViewModel {
    private let weatherService = WeatherService()

    private var loadingLabelTimer: Timer?
    private var indexMessage = 0
    private var networkCallTimer: Timer?
    private var indexNetworkCall = 0

    private let loadingMessageArray = [
        "Nous téléchargeons les données…",
        "C’est presque fini…",
        "Plus que quelques secondes avant d’avoir le résultat…"
    ]
    private let cities = [
        "Rennes",
        "Paris",
        "Nantes",
        "Bordeaux",
        "Lyon"
    ]

    var updateLoadingMessageHandler: () -> Void = {}
    var configureDisplayForLoadingHandler: () -> Void = {}
    var reloadTableViewHandler: () -> Void = {}
    var stopLoadingHandler: () -> Void = {}
    var errorMessageHandler: () -> Void = {}

    private(set) var loadingMessage: String = "Nous téléchargeons les données…" {
        didSet {
            updateLoadingMessageHandler()
        }
    }
    private(set) var weatherInfo: [WeatherInfo] = [] {
        didSet {
            reloadTableViewHandler()
        }
    }
    private(set) var error: String = "" {
        didSet {
            errorMessageHandler()
        }
    }

    func launchLoading() {
        loadingMessage = "Nous téléchargeons les données…"
        indexMessage = 0
        indexNetworkCall = 0
        weatherInfo = []
        startProgressLabelTimer()
        configureDisplayForLoadingHandler()
        startNetworksCalls()
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
    
    private func startNetworksCalls() {
        getResults(city: cities[indexNetworkCall])
        networkCallTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(networkCall), userInfo: nil, repeats: true)
    }

    @objc private func networkCall() {
        if indexNetworkCall <= 3 {
            indexNetworkCall += 1
            getResults(city: cities[indexNetworkCall])
        } else {
            networkCallTimer?.invalidate()
            networkCallTimer = nil
            loadingLabelTimer?.invalidate()
            loadingLabelTimer = nil
            stopLoadingHandler()
        }
    }

    private func getResults(city: String) {
        weatherService.get(city: city) { result in
            switch result {
            case .success(let data):
                self.weatherInfo.append(data)
            case .failure(let error):
                if let errorDescription = error.errorDescription {
                    self.error = errorDescription
                }
            }
        }
    }
}
