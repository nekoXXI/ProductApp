//
//  MenuRouter.swift
//  KGMartTz
//
//  Created by Адиль on 12/5/24.
//
import Foundation
import SwiftUI

protocol MenuRouter {
    func openMenu()
}

extension MenuRouter where Self: VCRouter {
    func openMenu() {
        let transition = PushTransition()
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = MenuViewModel(router: router)
        let view = MenuView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: MenuRouter { }
