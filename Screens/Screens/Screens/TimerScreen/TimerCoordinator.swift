//
//  TimerCoordinator.swift
//  Screens
//
//  Created by Mac on 26.10.2022.
//

import UIKit


class TimerCoordinator: Coordinator {
    enum Path {
        case exit
    }
    
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewController = controllerFromStoryboard(TimerViewController.self)
        let viewModel = TimerViewModel() { path in
            switch path {
            case .exit:
                self.closeScreen()
            }
        }
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .overCurrentContext
        rootViewController.present(viewController, animated: true)
    }
    
    private func closeScreen() {
        rootViewController.viewControllers.last?.dismiss(animated: true)
    }
}
