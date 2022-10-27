//
//  ViewController.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    var viewModel: StartViewModel?
    
    private let interBoldFontName = "Inter-Bold"
    private let buttonTitleFontSize: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        navigationController?.isNavigationBarHidden = true
        startButton.titleLabel?.font = UIFont(name: interBoldFontName, size: buttonTitleFontSize)
    }
    
    // MARK: - Actions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        viewModel?.startPressed()
    }
}

