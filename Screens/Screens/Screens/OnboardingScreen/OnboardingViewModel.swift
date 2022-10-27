//
//  BoostProductivityViewModel.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import Foundation

enum AlertPresentation {
    case none
    case timer
    case alert
}

class OnboardingViewModel {
    typealias PathAction = (OnboardingCoordinator.Path) -> Void

    private let pathAction: PathAction
    @Published var index = 0
    @Published var alertType: AlertPresentation = .none
    
    private let launchedBeforeKey = "launchedBefore"
    private let alreadyCreatedKey = "alreadyCreated"
    
    private let maxScreensIndex = 2
    
    init(pathAction: @escaping PathAction) {
        self.pathAction = pathAction
    }
    
    func saveToDataBase(screens: [String]) {
        if isNotCreatedInDataBase() {
            screens.forEach { name in
                CoreDataManager.shared.createScreen(name: name, numberOfViews: 0)
            }
        }
    }
    
    func showNextScreen() {
        if index == maxScreensIndex { alertType = isFirstRun() ? .timer : .alert }
        if index < maxScreensIndex { index += 1 }
    }
    
    func showTimer() {
        pathAction(.timer)
    }
    
    private func isFirstRun() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: launchedBeforeKey)
        if launchedBefore  {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: launchedBeforeKey)
            return true
        }
    }
    
    private func isNotCreatedInDataBase() -> Bool {
        let alreadyCreated = UserDefaults.standard.bool(forKey: alreadyCreatedKey)
        if alreadyCreated  {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: alreadyCreatedKey)
            return true
        }
    }
}
