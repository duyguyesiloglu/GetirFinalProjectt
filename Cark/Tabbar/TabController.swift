//
//  TabControllerViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 10.04.2024.
//

import UIKit

class TabController: UITabBarController , UITabBarControllerDelegate  {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.delegate = self
            setupTabs()
            addMiddleButton()
            tabbarStyle()
        }
        
        private func setupTabs() {
            let homeVC = HomeViewController()
            
            
            let searchVC = SearchViewController()
            
            
            let ortaVC = OrtaViewController()
            
            
            let profileVC = ProfileViewController()
            
            
            let carkVC = Cark()
            
            
            let homeNav = createNav(image: UIImage(named: "home"), vc: homeVC)
            let searchNav = createNav(image: UIImage(named: "search"), vc: searchVC)
            let ortaNav = createNav(image: UIImage(named: "menu"), vc: ortaVC)
            let profileNav = createNav(image: UIImage(named: "profile"), vc: profileVC)
            let carkNav = createNav(image: UIImage(named: "gift"), vc: carkVC)
            
            self.setViewControllers([homeNav, searchNav, ortaNav, profileNav, carkNav], animated: false)
            
            self.selectedIndex = 0
        }
        
        private func createNav(image: UIImage?, vc: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem.image = image
            return nav
        }
        
    private func addMiddleButton() {
        let middleButton = UIButton(type: .custom)
        middleButton.backgroundColor = UIColor(named: "moru")

        let buttonImage = UIImage(named: "menu")
        middleButton.setImage(buttonImage, for: .normal)

        let buttonSize: CGFloat = 60
        let buttonY = self.view.bounds.height - self.tabBar.frame.height - buttonSize + (self.tabBar.frame.height - buttonSize) / 6
        middleButton.frame = CGRect(x: (self.view.bounds.width - buttonSize) / 2, y: buttonY, width: buttonSize, height: buttonSize)

        middleButton.layer.cornerRadius = buttonSize / 2
        middleButton.addTarget(self, action: #selector(handleMenuButtonAct), for: .touchUpInside)

        self.view.addSubview(middleButton)
        self.tabBar.bringSubviewToFront(middleButton)
    }



        
        @objc private func handleMenuButtonAct() {
            // Orta butona basıldığında yapılacak işlemler
            print("Middle button tapped")
        }
        
        private func tabbarStyle() {
            // Tab bar görünümünü özelleştir
            tabBar.backgroundColor = .white // Tab bar arka plan rengi
            tabBar.tintColor = UIColor(named: "getirmorr") // Seçili tab item rengi
            tabBar.unselectedItemTintColor = .gray // Seçilmemiş tab item rengi
        }
        
        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
    }
