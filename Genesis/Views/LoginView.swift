//
//  LoginView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 03/08/23.
//

import SwiftUI

struct LoginView: View {
    @State private var isAuthenticated = false
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .padding()
            
            SecureField("Password", text: $password)
                .padding()
            
            Button(action: {
                NetworkManager.shared.login(username: username, password: password)
            }) {
                Text("Log In")
            }
            .padding()
        }
        .padding()
    }
}
