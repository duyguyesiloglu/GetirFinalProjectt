//
//  ProfileViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 10.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gri")
        self.navigationItem.title = "Profile"
        // Birinci view
                let view1 = UIView()
                view1.translatesAutoresizingMaskIntoConstraints = false
                view1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

                view.addSubview(view1)
                NSLayoutConstraint.activate([
                    view1.widthAnchor.constraint(equalToConstant: 556),
                    view1.heightAnchor.constraint(equalToConstant: 185),
                    view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
                    view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 104)
                ])

                // İkinci view
                let view2 = UIView()
                view2.translatesAutoresizingMaskIntoConstraints = false
                view2.backgroundColor = .clear
                
                view.addSubview(view2)
                NSLayoutConstraint.activate([
                    view2.widthAnchor.constraint(equalToConstant: 92),
                    view2.heightAnchor.constraint(equalToConstant: 19)
                ])
                
                // Üçüncü view (UILabel)
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
                label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
                label.text = "Product Name"
                
                view.addSubview(label)
                NSLayoutConstraint.activate([
                    label.widthAnchor.constraint(equalToConstant: 92),
                    label.heightAnchor.constraint(equalToConstant: 16),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    label.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 8)
                ])

        configureNavigationBar()
    }

    
    func configureNavigationBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "moru")
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] 

            // Apply the appearance settings to the navigation bar
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
}
