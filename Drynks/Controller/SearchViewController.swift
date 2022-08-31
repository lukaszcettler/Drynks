import UIKit

class SearchViewController: UIViewController {

// MARK: - Properties
    
    var drinkNetwork = DrinkNetwork()
    var drinks = [Drink]()
    
    let searchController = UISearchController()
    let tableView = UITableView()
    let notification = Notification.Name(rawValue: "Error")
   
    var searchWord: String?
    
    private lazy var session: URLSession = {
        URLCache.shared.memoryCapacity = 50 * 1024 * 1024
        let sessionConf = URLSessionConfiguration.default
        sessionConf.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: sessionConf)
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Drynks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        addSearchBar()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentAlert), name: notification, object: nil)
    }
    
// MARK: - Functions
    
    @objc func presentAlert(notification: NSNotification) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default))
        present(alert, animated: true)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(DrinkCell.self, forCellReuseIdentifier: "DrinkCell")
        tableView.rowHeight = 60
        tableView.pin(to: view)
        tableView.backgroundColor = .clear
    }
    
    func setTableViewDelegates() {
         tableView.delegate = self
         tableView.dataSource = self
    }
    
    func addSearchBar(){
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by ingredient"
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
    }
    
}

// MARK: - Extension TableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.row]
        let url = URL(string: drink.strDrinkThumb + "/preview")
        cell.preview(url: url!, session: session)
        cell.drinkLabel.text = drink.strDrink
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let drink = drinks[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        drinkNetwork.searchByID(id: drink.idDrink) { [weak self] fetchedDrink in
            detailVC.drinkDetail = fetchedDrink.drinks[0]
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .none)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

// MARK: - Extension SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchWord = searchBar.text
        
        drinkNetwork.searchByIngredient(searchWord: searchWord!) { [weak self] Drinks in
            self?.drinks = Drinks.drinks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
