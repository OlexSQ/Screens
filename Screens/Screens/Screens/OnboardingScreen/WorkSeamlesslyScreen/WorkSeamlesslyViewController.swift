//
//  WorkSeamlesslyViewController.swift
//  Screens
//
//  Created by Mac on 26.10.2022.
//

import UIKit

class WorkSeamlesslyViewController: UIViewController {

    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    
    private let viewModel = WorkSeamlesslyViewModel()
    private let interSemiBoldFontName = "Inter-SemiBold"
    private let interRegularFontName = "Inter-Regular"
    private let mainLabelFontSize: CGFloat = 28
    private let additionalLabelFontSize: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        viewModel.updateCounter(for: String(describing: type(of: self)))
    }
    
    private func setupLabels() {
        mainLabel.font = UIFont(name: interSemiBoldFontName, size: mainLabelFontSize)
        additionalLabel.font = UIFont(name: interRegularFontName, size: additionalLabelFontSize)
    }
}
