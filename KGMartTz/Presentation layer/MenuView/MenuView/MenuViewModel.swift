//
//  MenuViewModel.swift
//  KGMartTz
//
//  Created by Адиль on 12/5/24.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

protocol MenuBaseViewModel: ObservableObject {
    
    var pizza: [Pizza] { get set }
    var sushi: [Sushi] { get set }
    var drink: [Drink] { get set }
    
    func unsubscribe()
    func subscribe()
    func openMenuDetails(id: String, title: String, image: String, details: String, price: String, _ collectionState: MenuDetailsViewModel.CollectionState)
    func addProduct(_ title: String, _ image: String, _ price: String, _ details: String, type: ProductType)
    func handleCancelTapped()
    func logOut()
}

final class MenuViewModel: MenuBaseViewModel {
    enum collection {
        case pizza
        case sushi
        case drink
    }
    
    typealias Router = DefaultRouter
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    @Published var pizza = [Pizza]()
    @Published var sushi = [Sushi]()
    @Published var drink = [Drink]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    private var mainRouter = DefaultRouter(rootTransition: EmptyTransition())
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("pizza").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                self.pizza = documents.compactMap { (queryDocumentSnapshot) -> Pizza in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let image = data ["image"] as? String ?? ""
                    let price = data ["price"] as? String ?? ""
                    let details = data["details"] as? String ?? ""
                    return Pizza(id: id,
                                 title: title,
                                 image: image,
                                 price: price,
                                 details: details)
                }
            }
            listenerRegistration = db.collection("sushi").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                self.sushi = documents.compactMap { (queryDocumentSnapshot) -> Sushi in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let image = data ["image"] as? String ?? ""
                    let price = data ["price"] as? String ?? ""
                    let details = data["details"] as? String ?? ""
                    return Sushi(id: id,
                                 title: title,
                                 image: image,
                                 price: price,
                                 details: details)
                }
            }
            listenerRegistration = db.collection("drink").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                self.drink = documents.compactMap { (queryDocumentSnapshot) -> Drink in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let image = data ["image"] as? String ?? ""
                    let price = data ["price"] as? String ?? ""
                    let details = data["details"] as? String ?? ""
                    return Drink(id: id,
                                 title: title,
                                 image: image,
                                 price: price,
                                 details: details)
                }
            }
        }
    }
    
    func openMenuDetails(id: String, title: String, image: String, details: String, price: String, _ collectionState: MenuDetailsViewModel.CollectionState) {
        router.openMenuDetails(
            id: id,
            title: title,
            image: image,
            details: details,
            price: price,
            collectionState: collectionState
        )
    }
    
    func handleCancelTapped() {
        router.dismiss()
    }
    
    func addProduct(_ title: String, _ image: String, _ price: String, _ details: String, type: ProductType) {
        do {
            let _ = try! db.collection(type.typeTitle).addDocument(
                from: Pizza(title: title,
                            image: image,
                            price: price,
                            details: details)
            )
        }
        router.dismiss()
    }
    
    func logOut() {
        AppManager.authToken = nil
        
        let scene = UIApplication.shared.connectedScenes.first
        
        if let sceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setupControllers()
        }
    }
}
