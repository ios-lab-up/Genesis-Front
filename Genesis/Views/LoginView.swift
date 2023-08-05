//
//  LoginView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 03/08/23.
//

import SwiftUI

struct LoginView: View {
    @State private var isAuthenticated: Bool? = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Username", text: $username)
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                    
                    Button(action: {
                        NetworkManager.shared.login(username: username, password: password) { result in
                            switch result {
                            case .success(_):
                                self.isAuthenticated = true
                            case .failure(_):
                                self.showError = true
                            }
                        }
                    }) {
                        Text("Log In")
                    }
                    .padding()
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Login Failed"), message: Text("Please check your username and password and try again."), dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
                
                NavigationLink(destination: DashboardView(), tag: true, selection: $isAuthenticated) {
                    EmptyView()
                }
            }
        }
    }
}


