//
//  Transition.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import UIKit

protocol Transition: AnyObject {
    var isAnimated: Bool { get set }
    
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
