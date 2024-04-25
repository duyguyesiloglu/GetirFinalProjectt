//
//  SplashViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: BaseViewController {
    var presenter: SplashPresenterProtocol!
    
   
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            presenter.viewDidAppear()
            
            
            
           
            imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            
            UIView.animate(withDuration: 2.0, animations: {

                self.imageView.transform = CGAffineTransform.identity
            })
        }
        
    private func setupBackgroundColor() {
            
        self.view.backgroundColor = UIColor(named: "getirmorr")
        
        }
    
    

    }

    extension SplashViewController: SplashViewControllerProtocol {
        func noInternetConnection() {
            showAlert(title: "Error", message: "No Internet connection, please check your connection")
        }
    }
