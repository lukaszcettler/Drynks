import UIKit

class DrinkNetwork {
    
    func searchByIngredient(searchWord: String, completion: @escaping (Drinks)->()) {
        let request = URLRequest(url: Endpoints.searchByIngredient(searchWord).url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            print(data)
            guard let drinks = try? JSONDecoder().decode(Drinks.self, from: data) else {
                DispatchQueue.main.async {
                    let notification = Notification.Name(rawValue: "Error")
                    NotificationCenter.default.post(name: notification, object: nil)
                }
                return
            }
            print(drinks)
            completion(drinks)
        }.resume()
    }
    
    func searchByImage(url: URL, completion: @escaping (UIImage)->()) {
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            guard let data = data  else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }
    
    
    func searchByID(id: String, completion: @escaping (Drinks)->()) {
        
        let request = URLRequest(url: Endpoints.searchById(id).url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            guard let drink = try? JSONDecoder().decode(Drinks.self, from: data) else {
                return
            }
            completion(drink)
        }.resume()
    }
    
}
