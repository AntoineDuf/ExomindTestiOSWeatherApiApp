//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var progressBarLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.launchLoading()
    }
}

private extension WeatherViewController {
    func configureViewModel() {
        viewModel.updateLoadingMessageHandler = { [weak self] in
            guard let self = self else { return }
            self.progressBarLabel.text = self.viewModel.loadingMessage
        }
        viewModel.configureDisplayForLoadingHandler = { [weak self] in
            guard let self = self else { return }
            self.startLoadingDisplay()
        }
        viewModel.reloadTableViewHandler = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension WeatherViewController {
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

private extension WeatherViewController {
    func startLoadingDisplay() {
        UIView.animate(withDuration: 60) {
            self.progressBar.setProgress(1.0, animated: true)
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(CityWeatherTableViewCell.self)",
            for: indexPath
            ) as? CityWeatherTableViewCell else { fatalError() }
        cell.configureCell(weatherInfo: viewModel.weatherInfo[indexPath.row])
        return cell
    }
    
    
}
