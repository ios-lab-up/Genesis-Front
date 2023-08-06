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
            CustomTextField(text: $email, label: "Cedula", placeholder: "", sfSymbol: "heart.text.square.fill")
            CustomTextField(text: $email, label: "Birthday", placeholder: "", sfSymbol: "birthday.cake.fill")
            CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
            
            Spacer()
            
            Button(action: {
               
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