//
//  ViewModel.swift
//  TapAndGet
//
//  Created by Daniel Tvorun on 12.07.2022.
//

import UIKit

class ViewModel {
    public var quote = Dynamic("")
    public var imageData = Dynamic(Data())
    
    private var imageApiString = ""
    
    public func executeImageTask() {
        guard let url = URL(string: imageApiString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            self.imageData.value = data
        }.resume()
    }
    
    public func executeTextTask() {
        guard let url = URL(string: Constants.textApiString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let text = try JSONDecoder().decode(Quote.self, from: data)
                
                self.quote.value = "Kanye Rest: '\(text.quote)'"
            } catch {
                print(error)
            }
        }.resume()
    }
    
    public func setupUrlString(with imageWidth: String, _ imageHeight: String) {
        imageApiString = "\(Constants.imageApiString)\(imageWidth)/\(imageHeight)"
    }
}
