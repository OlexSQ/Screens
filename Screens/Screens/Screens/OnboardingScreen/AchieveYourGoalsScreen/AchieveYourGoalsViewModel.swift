//
//  AchieveYourGoalsViewModel.swift
//  Screens
//
//  Created by Mac on 26.10.2022.
//

import Foundation

class AchieveYourGoalsViewModel {
    func updateCounter(for screenName: String) {
        let screen = CoreDataManager.shared.fetchScreens(filter: screenName)
        guard let first = screen.first else { return }
        first.numberOfViews += 1
        CoreDataManager.shared.save()
    }
}
