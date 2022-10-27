//
//  BoostProductivityViewController.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import UIKit
import Combine

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private let boostProductivityViewController = controllerFromStoryboard(BoostProductivityViewController.self)
    private let workSeamlesslyViewController = controllerFromStoryboard(WorkSeamlesslyViewController.self)
    private let achieveYourGoalsViewController = controllerFromStoryboard(AchieveYourGoalsViewController.self)
    
    private var viewControllers = [UIViewController]()
    private var cancellables: Set<AnyCancellable> = []
    
    private var pageController: UIPageViewController?
    var viewModel: OnboardingViewModel?
    
    private let interBoldFontName = "Inter-Bold"
    private let buttonTitleFontSize: CGFloat = 16
    private let alertTitle = "Thank you for your interest"
    private let alertMessage = "The functionality is under development"
    private let continueButtonTitle = "Continue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.saveToDataBase(screens: [String(describing: type(of: boostProductivityViewController)), String(describing: type(of: workSeamlesslyViewController)), String(describing: type(of: achieveYourGoalsViewController))])
        setupPageController()
        setupNextButton()
        observeViewModel()
    }
    
    private func setupPageController() {
        viewControllers.append(boostProductivityViewController)
        viewControllers.append(workSeamlesslyViewController)
        viewControllers.append(achieveYourGoalsViewController)
        
        pageControll.numberOfPages = viewControllers.count
        
        self.pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        guard let first = viewControllers.first else { return }
        self.pageController?.setViewControllers([first], direction: .forward, animated: true)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width,height: containerView.frame.height)
        containerView.addSubview(self.pageController!.view)
    }
    
    private func setupNextButton() {
        nextButton.titleLabel?.font = UIFont(name: interBoldFontName, size: buttonTitleFontSize)
    }
    
    private func observeViewModel() {
        viewModel?.$index.sink { [weak self] index in
            guard let self = self, index != 0 else { return }
            self.pageControll.currentPage = index
            let controller = self.viewControllers[index]
            self.pageController?.setViewControllers([controller], direction: .forward, animated: true)
            if index == self.viewControllers.count - 1 {
                self.nextButton.setTitle(self.continueButtonTitle, for: .normal)
            }
        }.store(in: &cancellables)
        
        viewModel?.$alertType.sink { [weak self] alertType in
            guard let self = self else { return }
            
            switch alertType {
            case .none:
                return
            case .timer:
                self.viewModel?.showTimer()
            case .alert:
                self.showAlert(with: self.alertTitle, and: self.alertMessage)
            }
        }.store(in: &cancellables)
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setBackgroundColor(#colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2352941176, alpha: 1))
        alert.setTitleColor(.white)
        alert.setMessageColor(.white)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        viewModel?.showNextScreen()
    }
}

// MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < (viewControllers.count - 1) else { return nil }
        let after = index + 1
        return viewControllers[after]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        viewModel?.showNextScreen()
    }
}
