//
//  Photo.swift
//  Genesis
//

//  Created by Iñaki Sigüenza on 11/10/23.
//

import SwiftUI

struct Photo: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        NavigationView {
            VStack{
                
                if let image = vm.image {
                    ZoomableScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                }
                HStack{
                    Button(action: {
                        vm.source = .camera
                        vm.showPhotoPicker()
                    }){
                        Text("Camara")
                        
                    }
                    
                    Button(action: {
                        vm.source = .library
                        vm.showPhotoPicker()
                    }){
                        Text("Carrete")
                        
                    }
                }
                Spacer()
            }
            .navigationTitle("Analizar caso")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $vm.showPicker){
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
        }
        }
        
    }
}

#Preview {
    Photo()
}
