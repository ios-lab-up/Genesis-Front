//
//  enroll.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct enroll: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var birthday: String = ""
    @State private var cedula: String = ""

    var body: some View {
        VStack{
         
            CustomTextField(text: $name, label: "Name", placeholder: "", sfSymbol: "person.text.rectangle.fill")
            CustomTextField(text: $username, label: "Username", placeholder: "", sfSymbol: "person.fill")
            CustomTextField(text: $email, label: "Email", placeholder: "", sfSymbol: "envelope.fill")
            CustomTextField(text: $cedula, label: "Cedula", placeholder: "", sfSymbol: "heart.text.square.fill") // Updated binding
            CustomTextField(text: $birthday, label: "Birthday", placeholder: "", sfSymbol: "birthday.cake.fill") // Updated binding
            CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
            
            Spacer()
            
            Button(action: {
                // Example of using the signUp function
                NetworkManager.shared.signUp(name: self.name, username: self.username, email: self.email, password: self.password, birthDate: self.birthday, profileId: 2, cedula: self.cedula.isEmpty ? nil : self.cedula) { result in
                    switch result {
                    case .success(let user):
                        print("Registered user: \(user)")
                    case .failure(let error):
                        print("Failed to register user: \(error)")
                    }
                }
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 25)
                    .background(Color("Primary"))
                    .cornerRadius(100)
            }
            .padding(.top, 30)
            
        }
        .navigationTitle("Enroll as doctor")
        .navigationBarTitleDisplayMode(.large)
        .padding()
    }
}


struct enroll_Previews: PreviewProvider {
    static var previews: some View {
        enroll()
    }
}

//1625654
