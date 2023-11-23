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
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX") // Use a fixed locale for date formatting
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Adjust if necessary
        return formatter
    }()
    
    static let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM" // for "28 Nov" format
        formatter.locale = Locale(identifier: "es_MX") // Use the appropriate locale
        return formatter
    }()
    
}

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM" // Use the format "dd MMM" for day and abbreviated month
    formatter.locale = Locale(identifier: "es_MX") // Adjust for your locale
    return formatter
}()


struct DashboardView: View {
    //@EnvironmentObject var globalDataModel: GlobalDataModel
    @State private var navigateToNewView = false
    @State private var currentTime = Date()
    @State private var minutos = "5"
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    @State var showProfileView = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack(alignment: .leading){
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("yellowsito"))
                        VStack(alignment: .leading){
                            Text(currentTime, formatter: DateFormatter.timeFormatter)
                                .onReceive(timer) { input in
                                    currentTime = input
                                }
                                
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.black)
                                .cornerRadius(20)
                            Spacer()
                            Text("Tienes que tomar tu medicina en " + minutos + " minutos")
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .fontWeight(.bold)
    
                            
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
                    
                   
                    VStack(alignment: .leading, spacing: 20){
                        Text("¿Qué te gustaría hacer?")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                          
                        
                        
                        HStack{
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center))
                            {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("purplit"))
                                  
                                    
                                VStack{
                                  
                                    Text(globalDataModel.userImages.last?.mlDiagnostic.first?.sickness ?? "N/A")
                                        .foregroundColor(Color.white)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color.black)
                                        .cornerRadius(20)
                                        .padding()
                                    Text("Conoce tu Diagnóstico")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 15)
                                    
                                    Text("Conoce tu diagnóstico  a detalle")
                                        .font(.caption)
                                        .padding(.leading, 20)
                                        .foregroundColor(Color("grayish"))
                                        
                                    Spacer()
                                }
                            }
                            VStack(spacing: 10){
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color("bluey"))
                                    
                                    
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        HStack{
                                            Text("Lista de\nMedicamentos")
                                                .bold()
                                                .padding()
                                                .font(.subheadline)
                                                .fixedSize(horizontal: false, vertical: true)
                                            Spacer()
                                            
                                            ZStack{
                                                Circle()
                                                    .frame(width: 20, height: 20)
                                                Image(systemName: "chevron.right")
                                                    .foregroundStyle(Color.white)
                                                    .font(.caption)
                                            }
                                            .padding(.trailing, 10)
                                        }
                                     
                                        Text("Información detallada")
                                            .padding(.bottom)
                                            .padding(.horizontal)
                                            .font(.caption)
                                    }
                                }
                                
                                NavigationLink(destination: RecordGalleryView(imageDataList: globalDataModel.userImages)){
                                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        if let lastImageData = globalDataModel.userImages.last,
                                           let imageData = Data(base64Encoded: lastImageData.image),
                                           let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 100)
                                                .cornerRadius(20)
                                                .clipped()
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .opacity(0.5)
                                               
                                                .frame(height: 100)
                                            
                                            
                                            VStack(alignment: .leading){
                                                Spacer()
                                                HStack{
                                                    VStack(alignment: .leading){
                                                        Text("View records")
                                                            .font(.subheadline)
                                                            .foregroundColor(.white)
                                                            .bold()
                                                            .padding(.leading,10)
                                                        Text(reformatDateString(lastImageData.creationDate) ?? "No date available")
                                                            .font(.caption)
                                                            .bold()
                                                            .foregroundColor(.white)
                                                            .padding([.leading, .bottom], 10)
                                                    }
                                                    Spacer()
                                                    ZStack{
                                                        Circle()
                                                            .foregroundStyle(Color.white)
                                                            .frame(width: 20, height: 20)
                                                        Image(systemName: "chevron.right")
                                                            
                                                            .font(.caption)
                                                    }
                                                    .padding(.trailing, 10)
                                                }
                                                
                                              
                                            }
                                        } else {
                                            Color("bluey")
                                        }
                                        
                                        
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            
                                
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    .padding(.vertical)
                    
                    
                    
                    if let doctor = globalDataModel.userRelations.first { // Safely unwrapping the first doctor
                        VStack(alignment: .leading) {
                            DoctorInfoView(doctor: doctor)
                        }
                    } else {
                        Text("No doctor data available")
                            .padding()
                    }
                    
                }
                .fullScreenCover(isPresented: $showProfileView){
                    ProfileView()
                 
                        .environmentObject(globalDataModel)
                }
               
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
                            
                            ZStack{
                                AsyncImage(url: URL(string: "https://media.discordapp.net/attachments/856712471774494720/1134959498113589399/Memoji_Disc.png?width=809&height=809")) { image in
                                    
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            navigateToNewView = true
                                            
                                        }
                                } placeholder: {
                                    ZStack {
                                        Circle().foregroundColor(.purple)
                                    }
                                }
                                .frame(width: 45, height: 45)
                                
                                Button(action:{showProfileView.toggle()}){
                                   Circle()
                                        .foregroundStyle(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                }
                            }
                            
                            
                           
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
    
    
    func reformatDateString(_ dateString: String) -> String? {
        // Split the string by spaces and then by colons to extract the components
        let components = dateString.components(separatedBy: " ")
        
        // Check that all the necessary components are present
        if components.count >= 4 {
            let day = components[1]
            let month = components[2]
            let year = components[3]
            
            // Map the month string to its numerical representation
            let monthMap = ["Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
                            "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
                            "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"]
            if let monthNumber = monthMap[month] {
                // Extract the last two digits of the year
                let yearSuffix = String(year.suffix(2))
                // Combine the new string in the "YY.MM.DD" format
                return "\(yearSuffix).\(monthNumber).\(day)"
            }
        }
        // Return nil if the string does not contain a valid date
        return nil
    }
    
    
    
    
}




