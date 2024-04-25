//
//  OrtaViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 10.04.2024.
//

import UIKit

class OrtaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gri")
        setupNavigationBarImage()
        configureNavigationBar()
    }

    func setupNavigationBarImage() {
        guard let logo = UIImage(named: "getir") else { return }
        let imageView = UIImageView(image: logo)
        
        imageView.contentMode = .scaleAspectFit
        
        // Create a container view to add some padding around the image if needed
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30)) // Adjust these values based on your needs
        containerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120), // Maximum width
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 30) // Maximum height
        ])
        
        // Set the containerView as the titleView of the navigation item
        navigationItem.titleView = containerView
    }
    func configureNavigationBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "getirmorr")// Set the background color to purple
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Set title text color to white

            // Apply the appearance settings to the navigation bar
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
}
