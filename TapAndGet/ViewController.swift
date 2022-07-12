//
//  ViewController.swift
//  TapAndGet
//
//  Created by Daniel Tvorun on 12.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var urlString = ""
    
    var imageWidth = ""
    var imageHeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUrlString()
    }

    @IBAction func getButtonPressed(_ sender: UIButton) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func setupUrlString() {
        imageWidth = String(format: "%.0f", imageView.bounds.width)
        imageHeight = String(format: "%.0f", imageView.bounds.height)
        
        urlString = "https://picsum.photos/\(imageWidth)/\(imageHeight)"
    }
}

