//
//  VCRouter.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import UIKit
import SwiftUI

protocol Closable: AnyObject {
    func close()
}

protocol Dismissable: AnyObject {
    func dismiss()
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
}

protocol AnimatedTransition: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}

protocol VCRouter: Routable {
    var root: UIViewController? { get set }
}
