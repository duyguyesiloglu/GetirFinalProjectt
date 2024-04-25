//
//  SplashInteractor.swift
//  Week-4-VIPER
//
//  Created by Kerim Çağlar on 6.04.2024.
//

import Foundation

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = true // We can check via Reachiability
        self.output?.internetConnection(status: internetStatus)
    }
    
    
}
