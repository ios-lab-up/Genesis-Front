//
//  VerifyIdentityView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import SwiftUI

struct VerifyIdentityView: View {
    @State private var verificationCode = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Verification")) {
                    TextField("Verification Code", text: $verificationCode)
                }
                
                Section {
                    Button(action: verifyIdentity) {
                        Text("Verify Identity")
                    }
                }
            }
            .navigationBarTitle("Verify Identity")
        }
    }
    
    func verifyIdentity() {
        NetworkManager.shared.verifyIdentity(code: verificationCode) { result in
            switch result {
            case .success(let user):
                print("Verified user: \(user)")
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print("Failed to verify user: \(error)")
            }
        }
    }
}

struct VerifyIdentityView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyIdentityView()
    }
}
