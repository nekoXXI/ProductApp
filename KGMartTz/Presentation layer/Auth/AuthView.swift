//
//  AuthView.swift
//  KGMartTz
//
//  Created by Адиль on 3/5/24.
//

import SwiftUI

struct AuthView<ViewModel: AuthBaseViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    init(viewModel:ViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 40) {
            
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 30)
            
            VStack {
                Button(action: {
                    viewModel.createAccount(email: email, password: password)
                    
                }, label: {
                    HStack{
                        Text("Create an Account")
                            .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 40)
                })
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
            
            HStack {
                Text("Already have an account?")
                
                Button(action: {
                    viewModel.openLogIn()
                    print("fdsfs")
                }, label: {
                    Text("Sign in")
                        .foregroundColor(.blue)
                })
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
            
        }
    }
}
