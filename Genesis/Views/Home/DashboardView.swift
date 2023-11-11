//
//  DashboardView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI


struct DoctorInfoView: View {
    var doctor: User
    @State private var isSelected: Bool = false

    var body: some View {
        NavigationLink(destination: ChatView()) {
            RoundedRectangle(cornerRadius: 25)
                .fill(isSelected ? Color.blue : Color("primaryShadow"))
                .frame(height: 150)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text(doctor.name)
                            .font(.headline)
                            .foregroundColor(isSelected ? .white : .black)
                        Text(doctor.email)
                            .font(.subheadline)
                            .foregroundColor(isSelected ? .white : .black)
                    }
                    .padding(.all, 20),
                    alignment: .topLeading
                )
        }
        .isDetailLink(false) // This ensures that the link doesn't push onto the stack if it's already present
        .buttonStyle(PlainButtonStyle()) // To remove any button styling from the NavigationLink
        .onTapGesture {
            isSelected.toggle() // This will not work as expected because NavigationLink controls the navigation state
        }
        .animation(.default, value: isSelected)
    }
}
struct RecordThumbNailImageView: View {
    let imageData: [Genesis.ImageData] // Assuming this is an array now
    @State private var showFullScreenImage: Genesis.ImageData? // For tracking which image to show in full screen

    var body: some View {
        VStack(alignment: .leading) {
            if imageData.isEmpty {
                // Display a message when there are no records
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color("primaryShadow"))
                    .frame(width: 150, height: 180)
                    .overlay(
                        Text("There are no records")
                            .foregroundColor(.white)
                    )
            } else {
                ForEach(imageData, id: \.id) { data in
                    Button(action: {
                        showFullScreenImage = data // Assign the tapped image data for full screen view
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color("primaryShadow"))
                                .frame(width: 150, height: 180)

                            if let uiImage = UIImage(data: Data(base64Encoded: data.image) ?? Data()) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            } else {
                                Text("Image not available")
                                    .frame(width: 150, height: 180)
                                    .background(Color.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            }
                        }
                    }
                    .padding(.bottom, 10)

                    Text("Record \(data.id)")
                        .bold()
                        .padding(.top, 10)
                    Text(data.creationDate)
                        .font(.footnote)
                }
            }
        }
        .padding(.bottom)
        .fullScreenCover(item: $showFullScreenImage) { item in
            FullScreenImageView(image: Image(uiImage: UIImage(data: Data(base64Encoded: item.image) ?? Data())!), dismissAction: {
                showFullScreenImage = nil
            })
        }
    }
}

// FullScreenImageView remains unchanged and is used here as a modal presentation



struct DashboardView: View {
    @EnvironmentObject var globalDataModel: GlobalDataModel
    @State private var isImageFullScreen = false
    var body: some View {
        
        NavigationView {
            ScrollView{
            VStack{
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("primaryShadow"))
                    VStack(alignment: .leading){
                        Text("Welcome back")
                            .font(.title)
                        Text("\(globalDataModel.user?.name ?? "Guest")")
                            .font(.title)
                            .bold()
                        
                        
                        
                        Text("\(globalDataModel.user?.email ?? "Guest")")
                            .font(.footnote)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Get started")
                                .font(.footnote)
                                .foregroundStyle(.black)
                                .padding(5)
                        })
                        
                    }
                    .padding()
                }
                .frame(height: 200)
                .padding(.bottom, 10)
                
                
                
                if let doctor = globalDataModel.userRelations.first { // Safely unwrapping the first doctor
                    VStack(alignment: .leading) {
                        Text("Your Doctor")
                            .font(.title)
                        
                        DoctorInfoView(doctor: doctor)
                    }
                } else {
                    Text("No doctor data available")
                        .padding()
                }
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Records")
                            .font(.title)
                        Spacer()
                        // Updated NavigationLink to pass the userImages array to RecordGalleryView
                        NavigationLink(destination: RecordGalleryView(imageDataList: globalDataModel.userImages)) {
                            Text("View all")
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(globalDataModel.userImages, id: \.id) { imageData in
                                RecordThumbNailImageView(imageData: [imageData])
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .padding()
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Insights")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .bold()
                            
                            Spacer()
                            
                            // Profile picture
                            AsyncImage(url: URL(string: "https://media.discordapp.net/attachments/856712471774494720/1134959498113589399/Memoji_Disc.png?width=809&height=809")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        isImageFullScreen = true // When the image is tapped, set this state to true
                                    }
                                    .fullScreenCover(isPresented: $isImageFullScreen) {
                                        // This is the view that will be presented in full screen
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .edgesIgnoringSafeArea(.all)
                                    }
                            } placeholder: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.purple)
                                }
                            }
                            .frame(width: 60, height: 60) // Adjust the size as needed
                        }
                        .padding(.top, 30)
                    }

                }
            }
        }
            
    }

            
    }
    
    
    
    
    struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView().environmentObject(GlobalDataModel.shared)
        }
    }
    
    
}
