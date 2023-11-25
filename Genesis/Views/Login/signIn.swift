//
//  signIn.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI


struct signIn: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var isAuthenticated: Bool = false
    @State private var isPrivate: Bool = true
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Text("Sign In to continue")
                    .font(.title)
                    .bold()
                
                CustomTextField(text: $username, label: "Username", placeholder: "", sfSymbol: "person.fill")
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
                Button(action: {
                    login()
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
                  
                    
                    NavigationLink("Enroll now", destination: enroll())
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 14, weight: .medium))
                }
                
                
                       
                    
            }
            .padding(16)
            .fullScreenCover(isPresented: $isAuthenticated, content: {HomeView()})
            
            .ignoresSafeArea(.keyboard)
        
        }
        
    }
    
    func login() {
        NetworkManager.shared.login(username: username, password: password) { result in
            switch result {
            case .success(_):
                self.isAuthenticated = true                // Call fetchAllUserData after verification is successful
                NetworkManager.shared.fetchAllUserData { getUserResult in
                    switch getUserResult {
                    case .success(let fetchedUser):
                        print("Fetched user data: \(fetchedUser)")
                        FirebaseManager.shared.saveUsername { error in
                            if let error = error {
                                print("Failed to save username in firebase: \(error)")
                            } else {
                                print("Successfully saved username in firebase")
                            }
                        }
                    case .failure(let fetchError):
                        print("Failed to fetch user data: \(fetchError)")
                    }
                }
                
            case .failure(_):
                self.showError = true
            }
        }
    }
}


struct signIn_Previews: PreviewProvider {
    static var previews: some View {
        signIn().environmentObject(GlobalDataModel.shared)
    }
}
