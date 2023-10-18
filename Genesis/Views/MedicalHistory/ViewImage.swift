//
//  ViewImage.swift
//  Genesis
//
//  Created by Luis Cedillo M on 17/10/23.
//

import SwiftUI


struct ViewImage: View {
    let base64String: String

    var body: some View {
        if let data = Data(base64Encoded: base64String),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Text("Invalid Base64 String")
        }
    }
}

struct Base64Decode: View {
    let base64String = "your_base64_encoded_string_here"

    var body: some View {
        VStack {
            Text("Decoded Image:")
            ViewImage(base64String: base64String)
        }
    }
}


//struct ViewImage_Previews: PreviewProvider {
   // static var previews: some View {
   //     ViewImage(base64String:(()))
   //}
//}
