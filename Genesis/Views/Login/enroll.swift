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
    @State private var cedula: String = ""
    @State private var birthday: Date = Date()
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isEnrollSuccessful = false

    var body: some View {
        VStack{
         
            CustomTextField(text: $name, label: "Name", placeholder: "", sfSymbol: "person.text.rectangle.fill")
            CustomTextField(text: $username, label: "Username", placeholder: "", sfSymbol: "person.fill")
            CustomTextField(text: $email, label: "Email", placeholder: "", sfSymbol: "envelope.fill")
            CustomTextField(text: $cedula, label: "Cedula", placeholder: "", sfSymbol: "heart.text.square.fill")
            CustomDatePicker(date: $birthday, label: "Birthday", sfSymbol: "birthday.cake.fill")
            CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
            
            Spacer()
            
            Button(action: {
                            if name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty || cedula.isEmpty {
                                alertMessage = "Please fill all the fields"
                                showAlert = true
                            } else {
                                enroll()
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
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Enroll error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    .navigationTitle("Enroll as doctor")
                    .navigationBarTitleDisplayMode(.large)
                    .padding()
                    .fullScreenCover(isPresented: $isEnrollSuccessful, content: {oneTimeCode()})
                    
                }

                func enroll() {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let birthdayString = dateFormatter.string(from: birthday)

                    NetworkManager.shared.signUp(name: name, username: username.lowercased(), email: email.lowercased(), password: password, birthDate: birthdayString.lowercased(), profileId: 2, cedula: cedula.isEmpty ? nil : cedula) { result in
                        switch result {
                        case .success(let user):
                            print("Registered user: \(user)")
                            isEnrollSuccessful = true
                        case .failure(let error):
                            print("Failed to register user: \(error)")
                            alertMessage = "An error occurred while enrolling the doctor"
                            showAlert = true
                        }
                    }
                }
            }


struct enroll_Previews: PreviewProvider {
    static var previews: some View {
        enroll()
    }
}

//1625654
