import UIKit

extension DrinkNetwork {
    enum Endpoints {
        static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
        
        case getImage(String)
        case searchByIngredient(String)
        case searchById(String)
        
        var stringValue: String {
            switch self {
            case .getImage(let imagePath):
                return imagePath
            case .searchByIngredient(let searchWord):
                return Endpoints.baseURL + "filter.php?i=\(searchWord)"
            case .searchById(let id):
                return Endpoints.baseURL + "lookup.php?i=\(id)"
            }
        }
        var url: URL { return URL(string: stringValue)! }
    }
}
