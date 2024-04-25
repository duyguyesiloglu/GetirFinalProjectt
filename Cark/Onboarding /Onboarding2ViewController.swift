//
//  Onboarding2ViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import UIKit



class Onboarding2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0  // Allows label to wrap text
        titleLabel.text = "Connect to Courier"
        titleLabel.font = UIFont(name: "Roboto-BoldItalic", size: 30) // Choose an appropriate size
        titleLabel.textColor = UIColor(named: "moru")  // Set the color
        // Add the titleLabel to the view hierarchy
        self.view.addSubview(titleLabel)
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        // Constraints to position the titleLabel above the imageView
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),  // Space between titleLabel and imageView
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),  // Leading space to the parent view
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)  // Trailing space to the parent view
        ])
        
        
        // Constraints to center the imageView in the parent view and give it a proper size
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),  // Width constraint
            imageView.heightAnchor.constraint(equalToConstant: 300)  // Height constraint
        ])
        
        // Set the image for the base imageView
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "smartphone.png")
        
        // Create the overlayImageView to display the overlay image
        let overlayImageView = UIImageView()
        overlayImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(overlayImageView)
        
        // Constraints to position the overlayImageView 1 cm (38 points) from the top of the parent view
        NSLayoutConstraint.activate([
            overlayImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 38),
            overlayImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            overlayImageView.widthAnchor.constraint(equalToConstant: 100),  // Adjust if needed
            overlayImageView.heightAnchor.constraint(equalToConstant: 150)  // Adjust if needed
        ])
        
        // Set the image for the overlay imageView
        overlayImageView.contentMode = .scaleAspectFit
        overlayImageView.image = UIImage(named: "getir")
        
        let welcomeLabel = UILabel()
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                welcomeLabel.textAlignment = .center
                welcomeLabel.numberOfLines = 0  // Allows label to wrap text
                welcomeLabel.text = "You can track the courier's location and make changes to your address whenever you want"
        welcomeLabel.font = UIFont(name: "DmSerifDisplay-Regular", size: 16)
        welcomeLabel.tintColor = UIColor(named: "moru")
        // Adjust the size as needed
        

                // Add the label to the view hierarchy
                self.view.addSubview(welcomeLabel)

                // Constraints to position the welcomeLabel below the imageView
                NSLayoutConstraint.activate([
                    welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),  // Space between imageView and label
                    welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),  // Leading space to the parent view
                    welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)  // Trailing space to the parent view
                ])
    }
}

