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
    }
}

private extension WeatherViewController {
    func configureViewModel() {
        viewModel.updateLoadingMessage = { [weak self] in
            guard let self = self else { return }
            self.progressBarLabel.text = self.viewModel.loadingMessage
        }
    }
}

extension WeatherViewController {
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
