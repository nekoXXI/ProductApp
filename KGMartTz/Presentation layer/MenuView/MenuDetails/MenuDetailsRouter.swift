//
//  MenuDetailsRouter.swift
//  KGMartTz
//
//  Created by Адиль on 13/5/24.
//
import Foundation
import SwiftUI

protocol MenuDetailsRouter {
    func openMenuDetails(id: String, title: String, image: String, details: String, price: String, collectionState: MenuDetailsViewModel.CollectionState)
}

extension MenuDetailsRouter where Self: VCRouter {
    func openMenuDetails(id: String, title: String, image: String, details: String, price: String, collectionState: MenuDetailsViewModel.CollectionState) {
        let transition = PushTransition()
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = MenuDetailsViewModel(router: router, state: collectionState, id: id, title: title, image: image, details: details, price: price)
        let view = MenuDetailsView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        router.root = vc
        route(to: vc, as: transition)
    }
}

extension DefaultRouter: MenuDetailsRouter { }
