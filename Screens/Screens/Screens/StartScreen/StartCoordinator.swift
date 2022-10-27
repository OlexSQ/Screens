//
//  StartCoordinator.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import Foundation

import UIKit

class StartCoordinator: Coordinator {
    enum Path {
        case onboarding
    }
    
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = controllerFromStoryboard(StartViewController.self)
        let viewModel = StartViewModel() { path in
            switch path {
            case .onboarding:
                self.startOnboardingFlow()
            }
        }
        viewController.viewModel = viewModel
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func startOnboardingFlow() {
        OnboardingCoordinator(rootViewController: rootViewController).start()
    }
}
