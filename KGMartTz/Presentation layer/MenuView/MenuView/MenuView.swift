//
//  MenuView.swift
//  KGMartTz
//
//  Created by Адиль on 12/5/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct MenuView<ViewModel: MenuBaseViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var presentAddMenuSheet = false
    @State var presentLogOut = false
    @State private var titieText: String = ""
    @State private var imageText: String = ""
    @State private var priceText: String = ""
    @State private var detailsText: String = ""
    @State private var productType: ProductType = .pizza
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollViewReader { scrollView in
            HStack{
                Button {
                    withAnimation {
                        scrollView.scrollTo(0, anchor: .top)
                    }
                } label: {
                    Text("Scroll to Piiza")
                }
                .foregroundColor(Color.gray)
                .font(.system(size: 13))
                .padding(.horizontal, 5)
                
                Button {
                    withAnimation {
                        scrollView.scrollTo(1, anchor: .top)
                    }
                } label: {
                    Text("Scroll to Sushi")
                }
                .foregroundColor(Color.gray)
                .font(.system(size: 13))
                .padding(.horizontal, 5)
                
                Button {
                    withAnimation {
                        scrollView.scrollTo(2, anchor: .top)
                    }
                } label: {
                    Text("Scroll to Drinks")
                }
                .foregroundColor(Color.gray)
                .font(.system(size: 13))
                .padding(.horizontal, 5)
            }
            
            ScrollView {
                ForEach(viewModel.pizza) { pizza in
                    setupPizza(pizza)
                        .id(0)
                        .onTapGesture {
                            viewModel.openMenuDetails(
                                id: pizza.id ?? "",
                                title: pizza.title,
                                image: pizza.image,
                                details: pizza.details,
                                price: pizza.price, .pizza
                            )
                        }
                }
                
                ForEach(viewModel.sushi) { sushi in
                    setupSushi(sushi)
                        .id(1)
                        .onTapGesture {
                            viewModel.openMenuDetails(
                                id: sushi.id ?? "",
                                title: sushi.title,
                                image: sushi.image,
                                details: sushi.details,
                                price: sushi.price, .sushi
                            )
                        }
                }
                
                ForEach(viewModel.drink) { drink in
                    setupDrink(drink)
                        .id(2)
                        .onTapGesture {
                            viewModel.openMenuDetails(
                                id: drink.id ?? "",
                                title: drink.title,
                                image: drink.image,
                                details: drink.details,
                                price: drink.price, .drinks
                            )
                        }
                }
            }
            .background(Color.white)
            .navigationBarItems(leading: logOut)
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $presentAddMenuSheet,
                   content: {
                ProductAddView (
                    firstItem: ("Title", $titieText),
                    secondItem: ("Image", $imageText),
                    thirdItem: ("Price", $priceText),
                    forthItem: ("Details", $detailsText),
                    productType: $productType) {
                        viewModel.handleCancelTapped()
                    } saveCompletion: {
                        viewModel.addProduct(titieText, imageText, priceText, detailsText, type: productType)
                        titieText = ""
                        imageText = ""
                        priceText = ""
                        detailsText = ""
                    }
                
            })
            .onAppear() {
                self.viewModel.subscribe()
            }
        }
    }
    
    private func setupPizza(_ pizza: Pizza) -> some View {
        HStack {
            Text(pizza.image)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .border(Color.red)
                .padding(.horizontal, 30)
            
            
            VStack (alignment: .leading) {
                
                Text(pizza.title)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(pizza.details)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(pizza.price)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
            }
        }
    }
    
    private func setupSushi(_ sushi: Sushi) -> some View {
        HStack {
            Text(sushi.image)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .border(Color.red)
                .padding(.horizontal, 30)
            
            
            VStack (alignment: .leading) {
                
                Text(sushi.title)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(sushi.details)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(sushi.price)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
            }
        }
    }
    
    private func setupDrink(_ drink: Drink) -> some View {
        HStack {
            Text(drink.image)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .border(Color.red)
                .padding(.horizontal, 30)
            
            
            VStack (alignment: .leading) {
                
                Text(drink.title)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(drink.details)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
                Text(drink.price)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.vertical,1)
                
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            self.presentAddMenuSheet.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
    private var logOut: some View {
        Button(action: {
            viewModel.logOut()
        }) {
            Text("LogOut")
        }
    }
    
}
