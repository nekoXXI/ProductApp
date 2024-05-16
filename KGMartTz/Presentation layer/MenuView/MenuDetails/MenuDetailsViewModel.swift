//
//  MenuDetailsViewModel.swift
//  KGMartTz
//
//  Created by Адиль on 13/5/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

protocol MenuDetailsBaseViewModel: ObservableObject {
    var id: String { get set }
    var title: String { get  set }
    var image: String { get set }
    var details: String { get  set }
    var price: String { get set }
    var collectionState: MenuDetailsViewModel.CollectionState { get }
    
    func removeProduct()
    func handleCancelTapped()
    func updateProduct()
}

final class MenuDetailsViewModel: MenuDetailsBaseViewModel {
    
    enum CollectionState {
        case pizza
        case sushi
        case drinks
        
        var title: String {
            switch self {
            case .pizza:
                return "Pizza"
            case .sushi:
                return "Sushi"
            case .drinks:
                return "Drink"
            }
        }
    }
    
    var collectionState: CollectionState
    
    typealias Router = DefaultRouter
    private var router: Router
    private var db = Firestore.firestore()
    @Published var id: String
    @Published var title: String
    @Published var image: String
    @Published var details: String
    @Published var price: String
    
    init(router: Router, state: CollectionState, id: String, title: String, image: String, details: String, price:String) {
        self.router = router
        self.collectionState = state
        self.id = id
        self.title = title
        self.image = image
        self.details = details
        self.price = price
    }
    
    func removeProduct() {
        switch collectionState {
        case .pizza:
            db.collection("pizza").document(self.id).delete { error in
                
            }
        case .sushi:
            db.collection("sushi").document(self.id).delete { error in
                
            }
        case .drinks:
            db.collection("drink").document(self.id).delete { error in
                
            }
        }
        router.close()
    }
    
    func handleCancelTapped() {
        router.dismiss()
    }
    
    func updateProduct() {
        switch collectionState {
        case .pizza:
            do {
                try db.collection("pizza").document(self.id).setData(from: Pizza(title: title, image: image, price: price, details: details))
            } catch { }
        case .sushi:
            do {
                try db.collection("sushi").document(self.id).setData(from: Sushi(title: title, image: image, price: price, details: details))
            } catch { }
        case .drinks:
            do {
                try db.collection("drink").document(self.id).setData(from: Drink(title: title, image: image, price: price, details: details))
            } catch { }
        }
        router.close()
    } 
}
