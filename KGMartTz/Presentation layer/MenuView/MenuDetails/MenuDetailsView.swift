//
//  MenuDetailsView.swift
//  KGMartTz
//
//  Created by Адиль on 13/5/24.
//

import SwiftUI

struct MenuDetailsView<ViewModel: MenuDetailsBaseViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var presentEditProduct = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private var saveButton: some View {
        Button(action: {
            viewModel.updateProduct()
        }) {
            Text("Save")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text(viewModel.collectionState.title)) {
                TextField(viewModel.title, text: $viewModel.title)
            }
            
            Section(header: Text("Image")) {
                TextField(viewModel.image, text: $viewModel.image)
            }
            Section(header: Text("Price")) {
                TextField(viewModel.price, text: $viewModel.price)
            }
            Section(header: Text("Details")) {
                TextField(viewModel.details, text: $viewModel.details)
            }
            Section {
                Button("Delete") {
                    viewModel.removeProduct()
                }
                .foregroundColor(.red)
            }
        }
        .navigationBarItems(trailing: saveButton)
    }
}
