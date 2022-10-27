//
//  TimerViewController.swift
//  Screens
//
//  Created by Mac on 26.10.2022.
//

import UIKit
import Combine

class TimerViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var continueButton: UIButton!
    
    var viewModel: TimerViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    private let interBoldFontName = "Inter-Bold"
    private let interSemiBoldFontName = "Inter-SemiBold"

    private let buttonTitleFontSize: CGFloat = 16
    private let timerLabelFontSize: CGFloat = 68
    
    private let nonActiveButtonAlphaValue = 0.4
    private let activeButtonAlphaValue = 1.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        setupContinueButton()
        viewModel?.runTimer()
    }
    
    private func observeViewModel() {
        viewModel?.$continueButtonState.sink { [weak self] buttonState in
            switch buttonState {
            case .active:
                self?.makeContinueButtonActive()
            case .nonActive:
                print("Continue button nonActive")
            }
        }.store(in: &cancellables)
        
        viewModel?.$timerValue.sink { [weak self] value in
            DispatchQueue.main.async {
                self?.timerLabel.text = value
            }
        }.store(in: &cancellables)
        
        viewModel?.$progress.sink { [weak self] progress in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.5) {
                    self?.progressView.setProgress(progress , animated: true)
                }
            }
        }.store(in: &cancellables)
    }
    
    private func setupContinueButton() {
        continueButton.titleLabel?.font = UIFont(name: interBoldFontName, size: buttonTitleFontSize)
        continueButton.isEnabled = false
        continueButton.alpha = nonActiveButtonAlphaValue
    }
    
    private func setupTimerLabel() {
        timerLabel.font = UIFont(name: interSemiBoldFontName, size: timerLabelFontSize)
    }
    
    private func makeContinueButtonActive() {
        continueButton.isEnabled = true
        continueButton.alpha = activeButtonAlphaValue
    }
    
    // MARK: - Actions
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        viewModel?.continuePressed()
    }
}
