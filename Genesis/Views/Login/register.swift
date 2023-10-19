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
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isPrivate = true
    var body: some View {
        ScrollView{
            VStack{
                
                CustomTextField(text: $name, label: "Name", placeholder: "", sfSymbol: "person.text.rectangle.fill")
                CustomTextField(text: $username, label: "Username", placeholder: "", sfSymbol: "person.fill")
                CustomTextField(text: $email, label: "Email", placeholder: "", sfSymbol: "envelope.fill")
                CustomDatePicker(date: $birthday, label: "Birthday", sfSymbol: "birthday.cake.fill")
                ZStack{
                    if isPrivate{
                        CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
                    }
                    else
                    {
                        CustomTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.fill")
                    }
                    HStack{
                        Spacer()
                        Spacer()
                        Button("     "){
                            isPrivate.toggle()
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty {
                        alertMessage = "Please fill all the fields"
                        showAlert = true
                    } else {
                        signUp()
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
            .ignoresSafeArea(.keyboard)
            .navigationTitle("Create Account")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Register error"), message: Text(alertMessage), dismissButton: .default(Text("Close")))
            }
            .navigationBarTitleDisplayMode(.large)
            .padding()
            .fullScreenCover(isPresented: $isSignUpSuccessful, content: {oneTimeCode()})
        }}
    
    
    
    func signUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" 
        let birthdayString = dateFormatter.string(from: birthday)

        NetworkManager.shared.signUp(name: name, username: username.lowercased(), email: email.lowercased(), password: password, birthDate: birthdayString.lowercased(), profileId: profileId) { result in
            switch result {
            case .success(let user):
                print("Signed up user: \(user)")
                self.isSignUpSuccessful = true
            case .failure(let error):
                print("Failed to sign up user: \(error)")
                alertMessage = "An error occurred while signup user"
                showAlert = true
            }
        }
    }

}

struct register_Previews: PreviewProvider {
    static var previews: some View {
        register()
    }
}
