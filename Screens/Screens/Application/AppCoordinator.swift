//
//  AppCoordinator.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    private let rootViewController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = rootViewController
    }
    
    func start() {
        StartCoordinator(rootViewController: rootViewController).start()
    }
}
