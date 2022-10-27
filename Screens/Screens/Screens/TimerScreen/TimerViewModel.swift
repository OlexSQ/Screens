//
//  TimerViewModel.swift
//  Screens
//
//  Created by Mac on 26.10.2022.
//

import Foundation

enum ContinueButtonState {
    case active
    case nonActive
}

class TimerViewModel {
    typealias PathAction = (TimerCoordinator.Path) -> Void
    
    private let pathAction: PathAction
    private var timer = Timer()
    private let fullTime: Float = 60.0
    private var time = 60
    @Published var continueButtonState: ContinueButtonState = .nonActive
    @Published var timerValue = "01:00"
    @Published var progress: Float = 0.0
    
    init(pathAction: @escaping PathAction) {
        self.pathAction = pathAction
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func continuePressed() {
        pathAction(.exit)
    }
    
    @objc private func updateTime() {
        if time != 0 {
            time -= 1
            timerValue = timeFormatted(time)
            progress = (fullTime - Float(time)) / fullTime
        } else {
            stopTimer()
            continueButtonState = .active
        }
    }

     private func stopTimer() {
         timer.invalidate()
     }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
