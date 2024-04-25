//
//  SplashRouter.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import Foundation
import UIKit

enum SplashRoutes {
    case homeScreen
}

protocol SplashRouterProtocol {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter: SplashRouterProtocol {
    
    weak var viewcontroller: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter // Bu, presenter ile interactor arasındaki bağlantıyı kurar.
        router.viewcontroller = view
        
        return view
    }
    
    
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .homeScreen:
            let onboardingViewController = Onboarding1ViewController()
            
            // Eğer mevcut bir UINavigationController kullanılıyorsa, onboardingViewController'ı stack'e ekleyin.
            if let navigationController = viewcontroller?.navigationController {
                navigationController.pushViewController(onboardingViewController, animated: true)
            } else {
                // Eğer mevcut bir UINavigationController yoksa, yeni bir UINavigationController oluşturur ve onboardingViewController'ı root olarak atar.
                let navigationController = UINavigationController(rootViewController: onboardingViewController)
                navigationController.modalPresentationStyle = .fullScreen // Tam ekran modunda sunulur.
                viewcontroller?.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
}
