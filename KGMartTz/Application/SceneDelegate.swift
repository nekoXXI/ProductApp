//
//  SceneDelegate.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        setupControllers()
    }
    
    func setupControllers() {
        let mainRouter = DefaultRouter(rootTransition: EmptyTransition())
        
        if AppManager.authToken != nil {
            let viewModel = MenuViewModel(router: mainRouter)
            let view = MenuView(viewModel: viewModel)
            let vc = UIHostingController(rootView: view)
            let navigation = UINavigationController(rootViewController: vc)
            mainRouter.root = navigation
            setupWindow(navigation)
        } else {
            let viewModel = AuthViewModel(router: mainRouter)
            let welcomeView = AuthView(viewModel: viewModel)
            let vc = UIHostingController(rootView: welcomeView)
            let navigation = UINavigationController(rootViewController: vc)
            mainRouter.root = navigation
            setupWindow(navigation)
        }
    }
    
    private func setupWindow(_ controller: UIViewController) {
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

