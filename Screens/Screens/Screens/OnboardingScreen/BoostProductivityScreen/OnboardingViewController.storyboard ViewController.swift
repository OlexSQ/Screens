//
//  BoostProductivityViewController.swift
//  Screens
//
//  Created by Mac on 25.10.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var boostProductivityViewController = controllerFromStoryboard(<#T##viewController: VC.Type##VC.Type#>)
    
    private var pageController: UIPageViewController?
    var viewModel: OnboardingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: containerView.frame.width,height: containerView.frame.height)
        containerView.addSubview(self.pageController!.view)
        self.pageController?.didMove(toParent: self)
    }
    
    // MARK: - Action
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        print(#function)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
}
