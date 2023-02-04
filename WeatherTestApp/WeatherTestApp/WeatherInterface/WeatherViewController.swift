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
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var restartButton: UIButton!
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
            self.configureDisplayForLoading()
        }
        viewModel.reloadTableViewHandler = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.errorLabel.isHidden = true
        }
        viewModel.stopLoadingHandler = { [weak self] in
            guard let self = self else { return }
            self.stopLoading()
        }
        viewModel.errorMessageHandler = { [weak self] in
            guard let self = self else { return }
            self.stopLoading()
            self.errorLabel.text = self.viewModel.error
            self.errorLabel.isHidden = false
        }
    }
}

extension WeatherViewController {
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func restartButtonTapped(_ sender: Any) {
        viewModel.launchLoading()
    }
}

private extension WeatherViewController {
    func stopLoading() {
        tableView.isHidden = false
        progressBar.isHidden = true
        progressBarLabel.isHidden = true
        restartButton.isHidden = false
    }
    func configureDisplayForLoading() {
        tableView.isHidden = true
        progressBar.isHidden = false
        progressBarLabel.isHidden = false
        restartButton.isHidden = true
        startLoadingDisplay()
    }

    func startLoadingDisplay() {
        UIView.animate(withDuration: 0) {
            self.progressBar.setProgress(0.0, animated: true)
        }
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
