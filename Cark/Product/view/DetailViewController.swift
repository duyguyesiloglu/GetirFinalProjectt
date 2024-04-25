//
//  DetailViewController.swift
//  Getir
//
//  Created by Duygu Yesiloglu on 25.04.2024.
//
import UIKit

class DetailViewController: UIViewController {
    var productName: String?
    var price: String?
    var attribute: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 20))
        nameLabel.text = "Product: \(productName ?? "N/A")"
        view.addSubview(nameLabel)

        let priceLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 300, height: 20))
        priceLabel.text = "Price: \(price ?? "N/A")"
        view.addSubview(priceLabel)

        let attributeLabel = UILabel(frame: CGRect(x: 20, y: 160, width: 300, height: 20))
        attributeLabel.text = "Attribute: \(attribute ?? "N/A")"
        view.addSubview(attributeLabel)
    }
    func configure(withProductName productName: String, price: String, attribute: String) {
           self.productName = productName
           self.price = price
           self.attribute = attribute
       }
    
}

