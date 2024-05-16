//
//  AuthViewModel.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

protocol AuthBaseViewModel: ObservableObject {
    var signedIn: Bool { get set } 
    func openLogIn()
    func createAccount(email: String, password: String)
}

final class AuthViewModel: AuthBaseViewModel {
    
    @Published var signedIn:Bool = false
    
    typealias Router = DefaultRouter
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func openLogIn() {
        self.router.openLogIn()
    }
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error {
                
            } else {
                self?.router.openMenu()
            }
            
            AppManager.authToken = authResult?.user.uid
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                sceneDelegate.setupControllers()
            }
        }
        
    }
    
}
