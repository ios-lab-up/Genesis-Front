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
struct DoctorInfoView: View {
    var doctor: User
    @State private var isSelected: Bool = false
    @State var showchatView = false
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
        VStack{
            
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
                                    showchatView.toggle()
                                    
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
        .fullScreenCover(isPresented: $showchatView){
            ChatView()
        }
        
    }
}

struct DashboardView: View {
    //@EnvironmentObject var globalDataModel: GlobalDataModel
    @State private var isImageFullScreen = false
    @State private var currentTime = Date()
    @State private var minutos = "5"
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack{
                    
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
                    .padding(.horizontal, 15)
                    
                    HStack
                    {
                        Text("¿Qué te gustaría hacer?")
                        Spacer()
                    }.padding(.leading, 15)
                    
                    HStack{
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center))
                        {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("purplit"))
                                .frame(height: 200)
                                .padding(3)
                        }
                        VStack
                        {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("bluey"))
                            }
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                if let lastImageData = globalDataModel.userImages.last,
                                   let imageData = Data(base64Encoded: lastImageData.image),
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill() // Esto asegura que la imagen cubra todo el espacio disponible
                                        .frame(height: 100) // Asegúrate de que la altura coincida con la de tu ZStack
                                        .cornerRadius(20) // Aplica esquinas redondeadas
                                        .clipped() // Esto recorta la imagen para que se ajuste al marco y las esquinas
                                    
                                } else {
                                    Color("bluey") // Un color de fondo si no hay imagen disponible
                                }
                                
                                // ... Resto de tu contenido que va sobre la imagen ...
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100) // Asegúrate de que la altura coincida con la de la imagen
                            .padding(15)
                            
                            
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
                    
                }
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                VStack {
                                    
                                    Text(greetingText)
                                        .font(.title2)
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
                                .frame(width: 30, height: 30) // Adjust the size as needed
                            }
                            
                            
                            
                        }
                        
                    }
                }
            }
            
        }
        
        var greetingText: String {
            // Obtiene el nombre completo, o "Guest" si no hay un nombre disponible
            let fullName = globalDataModel.user?.name ?? "Guest"
            
            // Separa el nombre completo por espacios
            let nameComponents = fullName.components(separatedBy: " ")
            
            // Comprueba si hay un apellido
            if nameComponents.count > 1, let lastNameInitial = nameComponents.last?.first {
                // Si hay un apellido, usa solo la primera letra seguida de un punto
                let abbreviatedName = "\(nameComponents[0]) \(lastNameInitial)."
                return "Hola, \(abbreviatedName)"
            } else {
                // Si no hay apellido, devuelve el nombre completo
                return "Hola, \(fullName)"
            }
        }
        
        
    }
    
    
    

