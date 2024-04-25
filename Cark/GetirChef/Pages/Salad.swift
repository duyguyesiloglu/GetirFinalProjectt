//
//  Salad.swift
//  Getir
//
//  Created by Duygu Yesiloglu on 24.04.2024.
//

import Foundation
import UIKit

// Define your custom UICollectionViewCell
class SaladCell: UICollectionViewCell {
    
    static let identifier = "saladCollectionViewCell" // Ensure this identifier is unique and correct

   
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
        
        // Set translatesAutoresizingMaskIntoConstraints to false for Auto Layout
        [basketImageView, priceLabel, productNameLabel, attributeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Define and activate Auto Layout constraints
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

// Page3ViewController.swift
class SaladViewController: UIViewController {
    private var collectionView: UICollectionView!
    let titleLabel = UILabel()
    let foodImageView = UIImageView()
    let ingredientsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "gri")
        setupCollectionView()
        setupBottomView()
        setupUI()
        
    }
    private func setupUI() {
        // Configure Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "Ingredients"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Configure Food Image View
        foodImageView.contentMode = .scaleAspectFit
        foodImageView.image = UIImage(named: "5") // Replace with your actual image name
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodImageView)
        
        // Configure Ingredients Label
        ingredientsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientsLabel.textColor = .gray
        ingredientsLabel.text = "List of ingredients here" // Replace with your actual ingredients
        ingredientsLabel.numberOfLines = 0 // Allows for multiple lines
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ingredientsLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            // Constraints for Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            // Constraints for Food Image View
            foodImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            foodImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            foodImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            foodImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7), // Half the width of the view
            
            // Constraints for Ingredients Label
            ingredientsLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 100),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        view.backgroundColor = UIColor.white
    }
    
    private func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
           layout.minimumInteritemSpacing = 10
           layout.minimumLineSpacing = 10
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
               collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80), // Adjusted to give space for bottom view
               collectionView.heightAnchor.constraint(equalToConstant: 200)
           ])
       }


    private func setupBottomView() {
         let bottomView = UIView()
         bottomView.backgroundColor = UIColor(named: "moru")
         bottomView.layer.cornerRadius = 15
         view.addSubview(bottomView)

         let addButton = UIButton(type: .custom)
        addButton.setTitle("Add All", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20)
        addButton.contentHorizontalAlignment = .center // Metni ortalamak için hizalama ayarı
         addButton.backgroundColor = .clear // Ensure button is visible
         addButton.addTarget(self, action: #selector(addAllButtonTapped), for: .touchUpInside)
         bottomView.addSubview(addButton)

         bottomView.translatesAutoresizingMaskIntoConstraints = false
         addButton.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
             bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
             bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
             bottomView.heightAnchor.constraint(equalToConstant: 60),

             addButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
             addButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
             addButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
             addButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
         ])
     }

     @objc func addAllButtonTapped() {
         // Handle the tap event for the "Add All" button
         // Perform an action such as adding all items to the basket
     }
    
}

// MARK: - UICollectionViewDataSource and Delegate
extension SaladViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8 // This should be the number of items in your data source
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCollectionViewCell.identifier, for: indexPath) as? BasketCollectionViewCell else {
            fatalError("Unable to dequeue BasketCollectionViewCell")
        }
        
        switch indexPath.item {
            case 0:
            cell.configure(with: "biber", price: "€1,00", productName: "Pepper", attribute: "1 kg")
            case 1:
                cell.configure(with: "domates", price: "€2,00", productName: "Tomato", attribute: "1 kg")
            case 2:
                cell.configure(with: "misir", price: "€1,25", productName: "Corn", attribute: "200 gr")
            case 3:
                cell.configure(with: "zeytin", price: "€2,75", productName: "Sliced ​​Olives", attribute: "350 gr")
            case 4:
            cell.configure(with: "limon", price: "€0,50", productName: "Lemon", attribute: "1 piece")
            case 5:
            cell.configure(with: "marul", price: "€2,25", productName: "Lettuce", attribute: "1 piece")
            case 6:
            cell.configure(with: "sezar", price: "€5,00", productName: "Caesar Sauce", attribute: "250 gr")
            case 7:
            cell.configure(with: "sogan", price: "€3,00", productName: "Onion", attribute: "1 kg")
            default:
                break
            }
            
            return cell
        }
}

// Ensure to conform to UICollectionViewDelegateFlowLayout if you want to manually control the size of the cells
extension SaladViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the size as needed, for example:
        return CGSize(width: 100, height: 150)
    }
}
