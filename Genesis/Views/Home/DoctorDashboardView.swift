//
//  DoctorDashboardView.swift
//  Genesis
//
//  Created by Sara Cedillo M on 22/11/23.
//

import SwiftUI

struct DoctorDashboardView: View {
    let imageData = [1, 2, 3, 4, 5] // Dummy array for demonstration
    @State private var showFullScreenImage: Int? // State variable for selected image

    var body: some View {
        
        NavigationView{
            ZStack {
                VStack {
                    HStack {
                        Text("Pacientes recientes ")
                            .bold()
                            .padding(.leading, 20)
                        Spacer()
                    }
                        
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        // Horizontal stack for aligning items horizontally
                        HStack(spacing: 20) { // Spacing between elements in the HStack
                            // Loop through imageData
                            ForEach(imageData, id: \.self) { data in
                                Button(action: {
                                    showFullScreenImage = data
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color.gray)
                                            .frame(width: 150, height: 180)
                                        Text("Image \(data)")
                                            .frame(width: 150, height: 180)
                                            .background(Color.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    }
                                }
                            }
                        }.padding() // Padding around the HStack
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack {
                            Text("Hola, Dr.")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .bold()
                        }

                        Spacer()

                        ZStack {
                            AsyncImage(url: URL(string: "https://media.discordapp.net/attachments/856712471774494720/1134959498113589399/Memoji_Disc.png?width=809&height=809")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        // If you want to navigate to a new view, you can uncomment and use this
                                        // navigateToNewView = true
                                    }
                            } placeholder: {
                                Circle().foregroundColor(.purple)
                            }
                            .frame(width: 45, height: 45)

                            // If you plan to use a button, it should be here
                            // Button(action: { showProfileView.toggle() }) {
                            //    Circle()
                            //        .foregroundStyle(Color.clear)
                            //        .frame(width: 45, height: 45)
                            // }
                        }
                    }
                }
            }
        }
    }
}

struct DoctorDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorDashboardView()
    }
}

