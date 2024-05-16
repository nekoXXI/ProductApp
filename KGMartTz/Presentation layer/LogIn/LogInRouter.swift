//
//  LogInRouter.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import Foundation
import SwiftUI

protocol LogInRouter {
    func openLogIn()
}

extension LogInRouter where Self: VCRouter {
    func openLogIn() {
        let transition = PushTransition()
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LogInViewModel(router: router)
        let view = LogInView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: LogInRouter { }
