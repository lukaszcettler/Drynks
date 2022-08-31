import UIKit

class DrinkCell: UITableViewCell {

// MARK: - Properties
    
    static let id = "DrinkCell"
    var data: URLSessionDataTask!
    var drinkImageView = UIImageView()
    var drinkLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let dataTask = data {
            dataTask.cancel()
        }
        data = nil
        drinkImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(drinkImageView)
        addSubview(drinkLabel)

        setAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Functions
    func setAll(){
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
    
    func configureImageView() {
        drinkImageView.layer.cornerRadius = 10
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        drinkLabel.numberOfLines = 0
        drinkLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        drinkLabel.numberOfLines = 2
        drinkLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        drinkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        drinkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        drinkImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        drinkImageView.widthAnchor.constraint(equalTo: drinkImageView.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    func setTitleConstraints() {
        drinkLabel.translatesAutoresizingMaskIntoConstraints = false
        drinkLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        drinkLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 20).isActive = true
        drinkLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        drinkLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
// MARK: - Preview
    
    func preview(url: URL, session: URLSession) {
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
                if let error =  error {
                    print (error.localizedDescription)
                    return
                }
                guard let data = data  else { return }
                guard let previewImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.drinkImageView.image = previewImage
                }
            }
            task.resume()
            data = task
        }
}
