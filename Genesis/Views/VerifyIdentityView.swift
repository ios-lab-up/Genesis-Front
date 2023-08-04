//
//  VerifyIdentityView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 24/07/23.
//

import SwiftUI

struct VerifyIdentityView: View {
    @State private var isAuthenticated = false
    @State private var verificationCode = Array(repeating: "", count: 6)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Verification")) {
                    HStack {
                        ForEach(0..<6) { index in
                            TextField("", text: Binding(
                                get: { self.verificationCode[index] },
                                set: { newValue in
                                    if newValue.count <= 1 && newValue.last?.isNumber == true {
                                        self.verificationCode[index] = newValue
                                    }
                                }
                            ))
                            .multilineTextAlignment(.center)
                            .frame(width: 30, height: 30)
                            .border(Color.gray, width: 1)
                            .keyboardType(.numberPad)
                        }
                    }
                }
                
                Section {
                    Button(action: verifyIdentity) {
                        Text("Verify Identity")
                    }
                    
                    Button(action: resendCode) {
                        Text("Resend Code")
                    }
                }
            }
            .navigationBarTitle("Verify Identity")
        }
    }
    
    func verifyIdentity() {
        let code = verificationCode.joined()
        NetworkManager.shared.verifyIdentity(code: code) { result in
            switch result {
            case .success(let user):
                print("Verified user: \(user)")
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                print("Failed to verify user: \(error)")
            }
        }
    }
    
    func resendCode() {
        NetworkManager.shared.resendVerificationCode { result in
            switch result {
            case .success:
                print("Verification code resent successfully.")
            case .failure(let error):
                print("Failed to resend verification code: \(error)")
            }
        }
    }
}

struct VerifyIdentityView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyIdentityView()
    }
}
