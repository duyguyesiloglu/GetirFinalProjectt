//
//  PageOneViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import UIKit

class PageOneViewController: UIViewController {
    
    let titleLabel = UILabel()
    let foodImageView = UIImageView()
    let ingredientsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        foodImageView.image = UIImage(named: "3") // Replace with your actual image name
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodImageView)
        
        // Configure Ingredients Label
        ingredientsLabel.font = UIFont.systemFont(ofSize: 18)
        ingredientsLabel.textColor = .black
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
            foodImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            foodImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            foodImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            foodImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // Half the width of the view
            
            // Constraints for Ingredients Label
            ingredientsLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        view.backgroundColor = UIColor.white
    }
}
