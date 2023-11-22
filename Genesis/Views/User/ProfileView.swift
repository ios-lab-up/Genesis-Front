//
//  ProfileView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 10/11/23.
//
import SwiftUI

struct ProfileView: View {
    @State private var navigateToSignIn = false

    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue) // Choose your color
                .padding(.top, 50)
            
            Text("Username") // Replace with your dynamic username
                .font(.title)
                .padding(.top, 20)
            
            Text("Member since Jan 2023") // Replace with your dynamic date
                .font(.body)
                .padding(.top, 5)
            
            Spacer()
            
            Button(action: {
                NetworkManager.shared.signOut{ result in
                    print(result)                }
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .padding(.bottom, 50)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .fullScreenCover(isPresented: $navigateToSignIn, content: {
                    signIn()
                })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

