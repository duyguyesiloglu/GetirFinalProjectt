//
//  ProViewController.swift
//  Getir
//
//  Created by Duygu Yesiloglu on 24.04.2024.
//

import UIKit


class ProCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProCollectionViewCell"

    // Define the UI elements
    let basketImageView = UIImageView()
    let priceLabel = UILabel()
    let productNameLabel = UILabel()
    let attributeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Setup for basketImageView
        basketImageView.contentMode = .scaleAspectFit
        contentView.addSubview(basketImageView)
        contentView.backgroundColor = .white
        // Setup for priceLabel
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(priceLabel)
        
        // Setup for productNameLabel
        productNameLabel.textAlignment = .center
        productNameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(productNameLabel)
        
        // Setup for attributeLabel
        attributeLabel.textAlignment = .center
        attributeLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(attributeLabel)
        
        [basketImageView, priceLabel, productNameLabel, attributeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            basketImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basketImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            basketImageView.widthAnchor.constraint(equalToConstant: 92),
            basketImageView.heightAnchor.constraint(equalToConstant: 92),
            
            priceLabel.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: 4),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            productNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            attributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            attributeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with imageName: String, price: String, productName: String, attribute: String) {
        basketImageView.image = UIImage(named: imageName)
        priceLabel.text = price
        productNameLabel.text = productName
        attributeLabel.text = attribute
        
        priceLabel.textColor = UIColor(named: "moru")
        attributeLabel.textColor = .lightGray
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 10)
    }
}


class ProViewController: UIViewController, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private var scrollView: UIScrollView!
    
    let titleLabel = UILabel()
    let foodImageView = UIImageView()
    let ingredientsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gri")
        setupNavigationBar()
        setupCollectionView()
        setupScrollView()
    }
    
    

    private func setupNavigationBar() {
        self.navigationItem.title = "Products"
        self.navigationItem.backButtonTitle = ""
        // The tint color for the navigation bar items should be set on the navigation bar itself, not on the backBarButtonItem
        navigationController?.navigationBar.tintColor = .white

        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 85, height: 34))
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 8
        customView.layer.borderWidth = 1
        customView.layer.borderColor = UIColor.white.cgColor

        let iconImageView = UIImageView(image: UIImage(named: "Icon"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 5, y: 7, width: 20, height: 20)
        customView.addSubview(iconImageView)

        let label = UILabel(frame: CGRect(x: 30, y: 0, width: 50, height: 34))
        label.text = "₺0,00"
        label.textColor = UIColor(red: 0.365, green: 0.243, blue: 0.737, alpha: 1)
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textAlignment = .center
        customView.addSubview(label)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
            iconImageView.addGestureRecognizer(tapGesture)

        let customBarButtonItem = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = customBarButtonItem

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "moru")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    @objc func iconTapped() {
       
        let cartViewController = CartViewController()
        cartViewController.view.backgroundColor = .white // For testing
        cartViewController.navigationItem.title = "Cart"

        // Push the new view controller onto the stack
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 150)  // Adjust the size of each cell
        layout.minimumInteritemSpacing = 10               // Space between items in a row
        layout.minimumLineSpacing = 10                    // Space between rows, not necessary in horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: BasketCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150) // Set a fixed height for the collection view
        ])
    }
    
    private func setupScrollContent() {
            // Example of adding content to the scroll view
            let contentLabel = UILabel()
            contentLabel.translatesAutoresizingMaskIntoConstraints = false
            contentLabel.numberOfLines = 0
            contentLabel.text = ""
            scrollView.addSubview(contentLabel)

            NSLayoutConstraint.activate([
                contentLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
                contentLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
                contentLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
            ])

            // Important: Set the bottom constraint of the last element to the bottom of the contentLayoutGuide.
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20).isActive = true
        }
    private func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.backgroundColor = .white // Set background color to white for visibility
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)

            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10), // Space of 10 points from the collectionView
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])

            setupScrollContent()
        }
}

// MARK: - UICollectionViewDataSource and Delegate
extension ProViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCollectionViewCell.identifier, for: indexPath) as? BasketCollectionViewCell else {
            fatalError("BasketCollectionViewCell dequeue edilemedi")
        }
        
        switch indexPath.item {
        case 0:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        case 1:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        case 2:
            cell.configure(with: "basket", price: "₺0,25", productName: "Product Name", attribute: "Attribute")
        case 3:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        case 4:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        case 5:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        case 6:
            cell.configure(with: "basket", price: "₺0,00", productName: "Product Name", attribute: "Attribute")
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Hücre boyutunu ihtiyaca göre ayarlayın, örneğin:
        return CGSize(width: 100, height: 150)
    }
}
extension ProViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            // Özel bir sayfa aç
            let specialViewController = SpecialViewController()
            navigationController?.pushViewController(specialViewController, animated: true)
        } else {
            // Diğer hücreler için standart detay sayfasını aç
            let detailVC = DetailViewController()
            
            switch indexPath.item {
            case 1:
                detailVC.configure(withProductName: "Amoy Soya Sosu", price: "€3,00", attribute: "750 ml")
            case 2:
                detailVC.configure(withProductName: "Sushi Nori", price: "€4,25", attribute: "50 sheet")
            case 3:
                detailVC.configure(withProductName: "Sushi Mat", price: "€10,00", attribute: "-")
            default:
                break
            }

            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - SpecialViewController Definition
class SpecialViewController: UIViewController {
    let productImageView = UIImageView()
    let priceLabel = UILabel()
    let nameLabel = UILabel()
    let attributeLabel = UILabel()
    let addToBasketButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAddToBasketButton()
    }
    private func setupViews() {
        // Set view background color
        view.backgroundColor = .white // Assuming "gri" is a color set in your assets

        // Set navigation title
        navigationItem.title = "Product Detail"

        // Configure and add the product image view
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.backgroundColor = .lightGray // Placeholder color
        view.addSubview(productImageView)
        productImageView.image = UIImage(named: "markett")

        // Configure and add the price label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "₺0,00" // Replace with actual price
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textColor = UIColor(named: "moru") // Adjust color as needed
        view.addSubview(priceLabel)

        // Configure and add the product name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Product Name" // Replace with actual product name
        view.addSubview(nameLabel)

        // Configure and add the attribute label
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        attributeLabel.text = "Attribute" // Replace with actual attribute
        view.addSubview(attributeLabel)

        // Set constraints
        setupConstraints()
    }

    private func setupConstraints() {
        // Set image view constraints
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        // Set price label constraints
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Set name label constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Set attribute label constraints
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            attributeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setupAddToBasketButton() {
            addToBasketButton.setTitle("Add to Basket", for: .normal)
            addToBasketButton.backgroundColor = UIColor(named: "moru") // Assuming 'moru' is the purple color you want
            addToBasketButton.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 18) // Replace 'OpenSans-Regular' with the appropriate weight if needed
            addToBasketButton.layer.cornerRadius = 5 // Adjust corner radius to match your design
            addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(addToBasketButton)

            if let tabBar = self.tabBarController?.tabBar {
                NSLayoutConstraint.activate([
                    addToBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    addToBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    addToBasketButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBar.frame.size.height + 16)), // Adjusts the button to sit above the tab bar
                    addToBasketButton.heightAnchor.constraint(equalToConstant: 44) // Adjust height as necessary
                ])
            } else {
                NSLayoutConstraint.activate([
                    addToBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    addToBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    addToBasketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                    addToBasketButton.heightAnchor.constraint(equalToConstant: 44)
                ])
            }
        }
}
