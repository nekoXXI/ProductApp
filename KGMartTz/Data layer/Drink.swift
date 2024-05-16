//
//  Drink.swift
//  KGMartTz
//
//  Created by Адиль on 12/5/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Drink: Identifiable, Codable {
    @DocumentID var  id: String? = UUID().uuidString
    var title: String
    var image: String
    var price: String
    var details: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price
        case details
    }
}
