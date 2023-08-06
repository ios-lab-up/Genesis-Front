//
//  signIn.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI


struct signIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Text("Sign In to continue")
                    .font(.title)
                    .bold()
                
                CustomTextField(text: $email, label: "Email", placeholder: "", sfSymbol: "envelope.fill")
                CustomSecureTextField(text: $password, label: "Password", placeholder: "", sfSymbol: "eye.slash.fill")
                
                Button(action: {
                    
                       }) {
                           Text("Sign In")
                               .font(.headline)
                               .foregroundColor(.white)
                               .frame(maxWidth: .infinity)
                               .padding(.vertical, 25)
                               .background(Color("Primary"))
                               .cornerRadius(100)
                       }
                       .padding(.top, 30)
                
                Button(action: {} ){
                    Text("Forgot password?")
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 14, weight: .medium))
                }
                .padding(.top, 30)
                .padding(.bottom, 80)
                
               
                
                HStack{
                    Text("Dont have any account?")
                        .font(.system(size: 14, weight: .medium))
                    NavigationLink("Register", destination: register())
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 14, weight: .medium))
                }
                .padding(.bottom, 5)
                
                
                HStack{
                    Text("You are a doctor?")
                        .font(.system(size: 14, weight: .medium))
                  
                    
                    NavigationLink("Enroll now", destination: oneTimeCode())
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 14, weight: .medium))
                }
                
                
                       
                    
            }
            .padding(16)
            .ignoresSafeArea(.keyboard)
        
        }
        
    }
}


struct signIn_Previews: PreviewProvider {
    static var previews: some View {
        signIn()
    }
}
