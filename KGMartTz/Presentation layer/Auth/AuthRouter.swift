//
//  AuthRouter.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import Foundation
import SwiftUI

protocol AuthRouter {
    func openAuth()
}

extension AuthRouter where Self: VCRouter {
    func openAuth() {
        let transition = PushTransition()
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = AuthViewModel(router: router)
        let view = AuthView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        router.root = vc
        
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: AuthRouter { }
