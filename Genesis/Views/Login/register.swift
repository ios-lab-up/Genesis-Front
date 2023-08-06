//
//  register.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct register: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var birthday: Date = Date()
    @State private var password2: String = ""
    @State private var profileId = 1
    @State private var isSignUpSuccessful = false
    var body: some View {
        VStack{
         
            CustomTextField(text: $name, label: "Name", placeholder: "", sfSymbol: "person.text.rectangle.fill")
            CustomTextField(text: $username, label: "Username", placeholder: "", sfSymbol: "person.fill")
            CustomTextField(text: $email, label: "Email", placeholder: "", sfSymbol: "envelope.fill")
            CustomDatePicker(date: $birthday, label: "Birthday", sfSymbol: "birthday.cake.fill")
            CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
            
            Spacer()
            
            Button(action: {
               signUp()
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
        .ignoresSafeArea(.keyboard)
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .fullScreenCover(isPresented: $isSignUpSuccessful, content: {oneTimeCode()})
        }
    
    
    
    func signUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" 
        let birthdayString = dateFormatter.string(from: birthday)

        NetworkManager.shared.signUp(name: name, username: username, email: email, password: password, birthDate: birthdayString, profileId: profileId) { result in
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

struct register_Previews: PreviewProvider {
    static var previews: some View {
        register()
    }
}
