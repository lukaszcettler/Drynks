import UIKit

class DetailViewController: UIViewController {

// MARK: - Properties
    
    var drinkNetwork = DrinkNetwork()
    var drinkDetail: Drink?
    var ingredients: [Dictionary<String?, String?>] = []
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkGlass: UILabel!
    @IBOutlet weak var isAlcoholic: UILabel!
    @IBOutlet weak var drinkIngredients: UITextView!
    @IBOutlet weak var drinkInstructions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        drinkImage.layer.cornerRadius = 25
        displayDrinkDetailInformation()
    }

// MARK: - Functions
    
    func displayDrinkDetailInformation(){
        self.title = self.drinkDetail?.strDrink
        self.drinkInstructions.text = drinkDetail?.strInstructions
        self.drinkGlass.text = drinkDetail?.strGlass
        self.isAlcoholic.text = drinkDetail?.strAlcoholic
        getImage()
        createIngredientsList()
    }
    
    func getImage() {
        guard let url = URL(string: drinkDetail!.strDrinkThumb) else {
            return
        }
        drinkNetwork.searchByImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.drinkImage.image = image
            }
        }
    }
    
    func addIngredients(ingredient: String?, measure: String?){
        guard ingredient != nil else {return}
        drinkIngredients.text += ingredient!
        guard measure != nil else {return}
        drinkIngredients.text += " - \(measure!)\n"
    }

    func createIngredientsList(){
        drinkIngredients.text = ""
        addIngredients(ingredient: drinkDetail?.strIngredient1, measure: drinkDetail?.strMeasure1)
        addIngredients(ingredient: drinkDetail?.strIngredient2, measure: drinkDetail?.strMeasure2)
        addIngredients(ingredient: drinkDetail?.strIngredient3, measure: drinkDetail?.strMeasure3)
        addIngredients(ingredient: drinkDetail?.strIngredient4, measure: drinkDetail?.strMeasure4)
        addIngredients(ingredient: drinkDetail?.strIngredient5, measure: drinkDetail?.strMeasure5)
        addIngredients(ingredient: drinkDetail?.strIngredient6, measure: drinkDetail?.strMeasure6)
        addIngredients(ingredient: drinkDetail?.strIngredient7, measure: drinkDetail?.strMeasure7)
        addIngredients(ingredient: drinkDetail?.strIngredient8, measure: drinkDetail?.strMeasure8)
        addIngredients(ingredient: drinkDetail?.strIngredient9, measure: drinkDetail?.strMeasure9)
        addIngredients(ingredient: drinkDetail?.strIngredient10, measure: drinkDetail?.strMeasure10)
        addIngredients(ingredient: drinkDetail?.strIngredient11, measure: drinkDetail?.strMeasure11)
        addIngredients(ingredient: drinkDetail?.strIngredient12, measure: drinkDetail?.strMeasure12)
        addIngredients(ingredient: drinkDetail?.strIngredient13, measure: drinkDetail?.strMeasure13)
        addIngredients(ingredient: drinkDetail?.strIngredient14, measure: drinkDetail?.strMeasure14)
        addIngredients(ingredient: drinkDetail?.strIngredient15, measure: drinkDetail?.strMeasure15)
        
        if drinkIngredients.text != "" {
            drinkIngredients.text.removeLast()
        }
    }


}
