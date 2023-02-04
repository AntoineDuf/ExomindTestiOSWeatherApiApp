//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by Antoine Dufayet on 04/02/2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressBarLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
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
