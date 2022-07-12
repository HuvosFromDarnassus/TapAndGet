# TapAndGet

Educational project - a small JSON API practice project.

## 📸 Screenshot

![Simulator Screen Shot - iPhone 13 Pro Max - 2022-07-12 at 23 17 27](https://user-images.githubusercontent.com/58942445/178587775-a4ad347d-dc7a-4267-9afd-bb750199fefb.png)

## 🤖 APIs

- [Kanye Rest](https://api.kanye.rest) - Random Kanye West quote API.
- [Lorem Picsum](https://picsum.photos/) - Random stock image in any resolution.

## 🔨 Tech Stack

- UIKit
- Storyboard
- URLSession
- MVVM

## 🛠 Code example

### Binding dynamic class

```
class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
```

### ViewModel class

```
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
```
