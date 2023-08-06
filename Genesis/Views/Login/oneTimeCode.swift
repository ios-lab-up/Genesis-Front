//
//  oneTimeCode.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct oneTimeCode: View {
    
    static let codeDigits = 5
    @Environment(\.presentationMode) var presentationMode
    @State private var isSignUpSuccessful = false
    @State var codeDict = Dictionary<Int, String>(uniqueKeysWithValues: (0..<codeDigits).map{ ($0, "") })
      // [0:"", 1:"", ..., 5:""]
      
      var code: String {
          codeDict.sorted(by: { $0.key < $1.key }).map(\.value).joined()
      }
      
      
      var body: some View {
          VStack() {
              Text("Verification code")
                  .font(.title)
                  .bold()
              
              OneTimeCodeBoxes(codeDict: $codeDict,
                               onCommit: {
                                  print("onCommit", code)
                               })
                  .onChange(of: codeDict, perform: { _ in })
                  .font(.system(size: 14, weight: .semibold))
                  .padding()
              
              Button(action: {
                  verifyIdentity()
                     }) {
                         Text("Verify")
                             .font(.headline)
                             .foregroundColor(.white)
                             .frame(maxWidth: .infinity)
                             .padding(.vertical, 25)
                             .background(Color("Primary"))
                             .cornerRadius(100)
                     }
             
                     .padding()
              
              
              
              HStack{
                  Text("You dont have any code?")
                      .font(.system(size: 14, weight: .medium))
                  Button(action: {resendCode()}){
                      Text("Resend code")
                          .foregroundColor(Color("Primary"))
                          .font(.system(size: 14, weight: .medium))
                  }
                  
                      
              }
              
              
          }
          .padding(.vertical)
          
          
      }
    
    func verifyIdentity() {
        
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





struct oneTimeCode_Previews: PreviewProvider {
    static var previews: some View {
        oneTimeCode()
    }
}
