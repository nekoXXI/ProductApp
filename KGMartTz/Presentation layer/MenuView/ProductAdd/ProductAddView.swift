//
//  ProductAddView.swift
//  KGMartTz
//
//  Created by Адиль on 12/5/24.
//

import SwiftUI
import FirebaseFirestore

enum ProductType {
    case pizza
    case sushi
    case drinks
    
    var typeTitle: String {
        switch self {
        case .pizza:
            return "pizza"
        case .sushi:
            return "sushi"
        case .drinks:
            return "drink"
        }
    }
}

struct ProductAddView: View {
    
    @State var presentActionSheet = false
    @State var firstItem: (_title: String, item: Binding<String>)
    @State var secondItem: (_title: String, item: Binding<String>)
    @State var thirdItem: (_title: String, item: Binding<String>)
    @State var forthItem: (_title: String, item: Binding<String>)
    @Binding var productType: ProductType
    
    var cancelCompletion: (()-> Void)?
    var saveCompletion: (()-> Void)?
    
    var body: some View {
        VStack {
            HStack{
                
                Button(action: {
                    cancelCompletion?()
                }) {
                    Text("Cancel")
                }
                .padding(.horizontal, 10)
                Spacer()
                
                Text( "Add new item")
                Spacer()
                
                Button(action: {
                    saveCompletion?()
                }) {
                    Text( "Done")
                }
                .padding(.horizontal, 10)
                
            }
            .padding(.vertical, 10)
            Form {
                Section(header: Text(firstItem._title)) {
                    TextField(firstItem._title, text: firstItem.item)
                }
                
                Section(header: Text(secondItem._title)) {
                    TextField(secondItem._title, text: secondItem.item)
                }
                Section(header: Text(thirdItem._title)) {
                    TextField(thirdItem._title, text: thirdItem.item)
                }
                Section(header: Text(forthItem._title)) {
                    TextField(forthItem._title, text: forthItem.item)
                }
                Section {
                    Button("What do you want to add?") {
                        print("dsada")
                        self.presentActionSheet.toggle()
                    }
                    .foregroundColor(.blue)
                }
            }
            .actionSheet(isPresented: $presentActionSheet) {
                let actionPizza = ActionSheet.Button.default(Text("Pizza")) {
                    productType = .pizza
                }
                
                let actionSushi = ActionSheet.Button.default(Text("Sushi")) {
                    productType = .sushi
                }
                
                let actionDrink = ActionSheet.Button.default(Text("Drinks")) {
                    productType = .drinks
                }
                
                return ActionSheet(title: Text("What do you want to add?"), buttons: [actionPizza, actionSushi, actionDrink])
            }
        }
    }
}
