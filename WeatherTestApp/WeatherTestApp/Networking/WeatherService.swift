//
//  WeatherService.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import Foundation
import Alamofire

final class WeatherService {
    func get(
        city: String,
        completion: @escaping (Result<WeatherInfo, AFError>) -> Void
    ) {
        let apiKey = "0bea5b117f2e763e5650645d21327e25"
        let parameters = [
            "q": city,
            "units": "metric",
            "lang": "fr",
            "APPID": apiKey
        ]
        Alamofire.AF
            .request("https://api.openweathermap.org/data/2.5/weather?", parameters: parameters)
            .response { responseData in
                guard let data = responseData.data,
                      responseData.response?.statusCode == 200,
                      let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                    if let error = responseData.error {
                        completion(.failure(error))
                    }
                    return
                }
                completion(.success(weatherInfo))
            }
    }
}
