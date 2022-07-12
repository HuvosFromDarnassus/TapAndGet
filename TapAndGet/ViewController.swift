//
//  ViewController.swift
//  TapAndGet
//
//  Created by Daniel Tvorun on 12.07.2022.
//

import UIKit

struct RandomText: Decodable {
    let quote: String
}

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imageApiString = ""
    let textApiString = "https://nodejs-quoteapp.herokuapp.com/quote"
    
    var imageWidth = ""
    var imageHeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUrlString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        executeImageTask()
        executeTextTask()
    }

    @IBAction func getRandomImageButtonPressed(_ sender: UIButton) {
        executeImageTask()
    }
    
    @IBAction func getRandomTextPressed(_ sender: UIButton) {
        executeTextTask()
    }
    
    func executeImageTask() {
        guard let url = URL(string: imageApiString) else { return }
        
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
    
    func executeTextTask() {
        guard let url = URL(string: textApiString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let text = try JSONDecoder().decode(RandomText.self, from: data)
                
                DispatchQueue.main.async {
                    self.label.text = text.quote
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func setupUrlString() {
        imageWidth = String(format: "%.0f", imageView.bounds.width)
        imageHeight = String(format: "%.0f", imageView.bounds.height)
        
        imageApiString = "https://picsum.photos/\(imageWidth)/\(imageHeight)"
    }
}

