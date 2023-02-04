//
//  CityWeatherTableViewCell.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import UIKit


class CityWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    func configureCell(weatherInfo: WeatherInfo) {
        cityLabel.text = weatherInfo.name
        temperatureLabel.text = "\(Int(weatherInfo.main.temp))°"
        if let weatherIconNam = weatherInfo.weather.first?.icon {
            weatherImage.image = UIImage(named: weatherIconNam)
        }
    }
}
