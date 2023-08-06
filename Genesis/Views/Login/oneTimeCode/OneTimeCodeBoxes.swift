//
//  OneTimeCodeBoxes.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

struct OneTimeCodeBoxes: View {
    
    @Binding var codeDict: [Int: String]
    @State var firstResponderIndex = 0
    var onCommit: (()->Void)?
    
    var body: some View {
        HStack {
            ForEach(0..<codeDict.count) { i in
                let isEmpty = codeDict[i]?.isEmpty == true
                
                OneTimeCodeInput(
                    index: i,
                    codeDict: $codeDict,
                    firstResponderIndex: $firstResponderIndex,
                    onCommit: onCommit
                )
                .aspectRatio(1, contentMode: .fit)
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: isEmpty ? 1 : 2)
                            .foregroundColor(isEmpty ? .clear : Color("Primary")))
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("Secondary")))
               
               
            }
        }
    }
}

struct OneTimeCodeBoxes_Previews: PreviewProvider {
    static var previews: some View {
        OneTimeCodeBoxes(codeDict: .constant([0: "", 1: "", 2: "", 3: ""]))
            .padding()
            .font(.footnote)
         
        
        OneTimeCodeBoxes(codeDict: .constant([0: "1", 1: "2", 2: ""]))
            .font(.footnote)
            
            .padding()
           
    }
}
