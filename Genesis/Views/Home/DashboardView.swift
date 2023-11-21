//
//  DashboardView.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 06/08/23.
//

import SwiftUI

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium // You can adjust the format as needed
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()
}
struct DiagnosticView: View {
    var doctor: User
    @State private var isSelected: Bool = false
    let currentDate = Date()
        let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            return formatter
        }()
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            formatter.locale = Locale(identifier: "en_US_POSIX") // Use a locale that ensures the month is in uppercase English
            return formatter
        }()
    var body: some View {
        NavigationLink(destination: ChatView()) {
            RoundedRectangle(cornerRadius: 25)
                .fill(isSelected ? Color.blue : Color("blackish"))
                .frame(height: 150)
                .overlay(
                    HStack{
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            Text(doctor.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.top,15)
                                .padding(.leading, 15)
                            Text(doctor.email)
                                .font(.subheadline)
                                .foregroundColor(Color("primaryShadow"))
                                .padding(.leading, 15)
                            HStack
                            {
                                Button(action: {
                                    // Alguien cambie estooo
                                    print("Llevar al chat que aun no está")
                                }) {
                                    Text("Enviar Mensaje")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Color("yellowsito"))
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color("yellowsito"), lineWidth: 1)
                                        )
                                }
                                .padding()
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            VStack {
                                Text(dayFormatter.string(from: currentDate))
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text(monthFormatter.string(from: currentDate).uppercased())
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 70, height: 80)
                            .background(Color.black)
                            .cornerRadius(15)
                            Text("Prox. Cita")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 70, height: 20)
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        Spacer()
                    }
                ).padding(15)
        }
        .isDetailLink(false) // This ensures that the link doesn't push onto the stack if it's already present
        .buttonStyle(PlainButtonStyle()) // To remove any button styling from the NavigationLink
        .onTapGesture {
            isSelected.toggle() // This will not work as expected because NavigationLink controls the navigation state
        }
        .animation(.default, value: isSelected)
    }
}
struct DoctorInfoView: View {
    var doctor: User
    @State private var isSelected: Bool = false
    let currentDate = Date()
        let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            return formatter
        }()
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            formatter.locale = Locale(identifier: "en_US_POSIX") // Use a locale that ensures the month is in uppercase English
            return formatter
        }()
    var body: some View {
        NavigationLink(destination: ChatView()) {
            RoundedRectangle(cornerRadius: 25)
                .fill(isSelected ? Color.blue : Color("blackish"))
                .frame(height: 150)
                .overlay(
                    HStack{
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            Text(doctor.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.top,15)
                                .padding(.leading, 15)
                            Text(doctor.email)
                                .font(.subheadline)
                                .foregroundColor(Color("primaryShadow"))
                                .padding(.leading, 15)
                            HStack
                            {
                                Button(action: {
                                    // Alguien cambie estooo
                                    print("Llevar al chat que aun no está")
                                }) {
                                    Text("Enviar Mensaje")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Color("yellowsito"))
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color("yellowsito"), lineWidth: 1)
                                        )
                                }
                                .padding()
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            VStack {
                                Text(dayFormatter.string(from: currentDate))
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text(monthFormatter.string(from: currentDate).uppercased())
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 70, height: 80)
                            .background(Color.black)
                            .cornerRadius(15)
                            Text("Prox. Cita")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 70, height: 20)
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        Spacer()
                    }
                ).padding(15)
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
    @State private var currentTime = Date()
    @State private var minutos = "5"

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        
        NavigationView {
            ScrollView{
            VStack{
                HStack
                {
                    Text("¿Cómo te sientes hoy?")
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15)
                    Spacer()
                }
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("yellowsito"))
                    VStack(alignment: .leading){
                        Text(currentTime, formatter: DateFormatter.timeFormatter)
                                    .onReceive(timer) { input in
                                        currentTime = input
                                    }
                                    .font(.system(size: 24)) // Set the font size to your preference
                                    .fontWeight(.medium) // Adjust the font weight as needed
                                    .foregroundColor(Color.white) // Set the text color to white
                                    .padding(.vertical, 8) // Add vertical padding
                                    .padding(.horizontal, 16) // Add horizontal padding
                                    .background(Color.black) // Set the background color to black
                                    .cornerRadius(20)
                        Spacer()
                        Text("Tienes que tomar tu medicina en " + minutos + " minutos")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.bold)
                        //Text("\(globalDataModel.user?.name ?? "Guest")")
                            //.font(.title)
                            //.bold()
                        
                        //Text("\(globalDataModel.user?.email ?? "Guest")")
                            //.font(.footnote)
                        
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
                .padding(15)
        
                HStack
                {
                    Text("¿Qué te gustaría hacer?")
                    Spacer()
                }.padding(15)
                
                HStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(Color("yellowsito"))
                                        }
                    VStack
                    {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("yellowsito"))
                        }
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("yellowsito"))
                    }
                    
                    }
                }.padding(15)
                
                    
                
                if let doctor = globalDataModel.userRelations.first { // Safely unwrapping the first doctor
                    VStack(alignment: .leading) {
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
                            VStack {
                            
                                Text("Hola, " + (globalDataModel.user?.name ?? "Guest"))
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                    .bold()
                                
                            }
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
