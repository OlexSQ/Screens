//
//  BoostProductivityCoordinator.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    enum Path {
        case timer
    }
    
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = controllerFromStoryboard(OnboardingViewController.self)
        let viewModel = OnboardingViewModel() { path in
            switch path {
            case .timer:
                self.runTimerFlow()
            }
        }
        viewController.viewModel = viewModel
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func runTimerFlow() {
        TimerCoordinator(rootViewController: rootViewController).start()
    }
}
