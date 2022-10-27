//
//  StartViewModel.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import Foundation

class StartViewModel {
    typealias PathAction = (StartCoordinator.Path) -> Void
        
    private let pathAction: PathAction
    
    init(pathAction: @escaping PathAction) {
        self.pathAction = pathAction
    }
    
    func startPressed() {
        pathAction(.onboarding)
    }
}
