//
//  SignUp.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//



import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var birthDate = ""
    @State private var profileId = 1
    @State private var isSignUpSuccessful = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                        TextField("Name", text: $name)
                        TextField("Username", text: $username)
                                        .onChange(of: username) { newValue in
                                            username = newValue.lowercased()
                                        }
                        TextField("Email", text: $email)
                                        .onChange(of: email) { newValue in
                                            email = newValue.lowercased()
                                        }
                                    SecureField("Password", text: $password)
                        TextField("Birth Date", text: $birthDate)
                }
                
                Section {
                    Button(action: signUp) {
                        Text("Sign Up")
                    }
                }
            }
            .navigationBarTitle("Sign Up")
            .sheet(isPresented: $isSignUpSuccessful) {
                VerifyIdentityView()
            }
        }
    }
    
    func signUp() {
        NetworkManager.shared.signUp(name: name, username: username, email: email, password: password, birthDate: birthDate, profileId: profileId) { result in
            switch result {
            case .success(let user):
                print("Signed up user: \(user)")
                self.isSignUpSuccessful = true
            case .failure(let error):
                print("Failed to sign up user: \(error)")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

			

