//
//  DefaultRouter.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//
import UIKit

class DefaultRouter: NSObject, VCRouter, Closable, Dismissable {
    private let rootTransition: Transition
    weak var root: UIViewController?
    
    init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }
    
    // MARK: - Routable
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        guard let root = root else { return }
        transition.open(viewController, from: root, completion: completion)
    }
    
    func route(to viewController: UIViewController, as transition: Transition) {
        route(to: viewController, as: transition, completion: nil)
    }
    
    // MARK: - Closable
    
    func close(completion: (() -> Void)?) {
        guard let root = root else { return }
        rootTransition.close(root, completion: completion)
    }
    
    func close() {
        close(completion: nil)
    }
    
    // MARK: - Dismissable
    func dismiss(completion: (() -> Void)?) {
        root?.dismiss(animated: rootTransition.isAnimated, completion: completion)
    }
    
    func dismiss() {
        dismiss(completion: nil)
    }
}
