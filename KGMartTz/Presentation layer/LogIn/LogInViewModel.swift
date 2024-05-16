//
//  LogInViewModel.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth

protocol LogInBaseViewModel: ObservableObject {
    
    func signIn(email:String, password:String, completion: @escaping (Error?) -> Void)
}

final class LogInViewModel: LogInBaseViewModel {
    
    typealias Router = DefaultRouter
    private let router: Router
    private var window: UIWindow?
    
    init(router: Router) {
        self.router = router
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
            AppManager.authToken = authResult?.user.uid
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = scene?.delegate as? SceneDelegate {
                sceneDelegate.setupControllers()
            }
        }
    }
}
