//
//  ViewController.swift
//  TapAndGet
//
//  Created by Daniel Tvorun on 12.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var label: UILabel!
    
    private let viewModel: ViewModel = ViewModel()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        viewModel.executeImageTask()
        viewModel.executeTextTask()
    }
    
    @IBAction private func getRandomImageButtonPressed(_ sender: UIButton) {
        viewModel.executeImageTask()
    }
    
    @IBAction private func getRandomTextPressed(_ sender: UIButton) {
        viewModel.executeTextTask()
    }
    
    private func bindViewModel() {
        viewModel.imageData.bind { (data) in
            DispatchQueue.main.async {
                UIView.transition(with: self.imageView,
                                  duration: 0.3,
                                  options: .transitionCurlUp,
                                  animations: { self.imageView.image = UIImage(data: data) },
                                  completion: nil)
            }
        }
        
        viewModel.quote.bind { quote in
            DispatchQueue.main.async {
                self.label.text = quote
            }
        }
    }
    
    private func setupViewController() {
        bindViewModel()
        
        let imageWidth = String(format: "%.0f", imageView.bounds.width)
        let imageHeight = String(format: "%.0f", imageView.bounds.height)
        
        viewModel.setupUrlString(with: imageWidth, imageHeight)
    }
}

