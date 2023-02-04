//
//  WeatherInfo.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import Foundation

import Foundation

struct WeatherInfo: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
}
