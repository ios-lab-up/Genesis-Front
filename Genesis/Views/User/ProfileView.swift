//
//  ProfileView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 10/11/23.
//
import SwiftUI
import HealthKit

struct ProfileView: View {
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    @State private var navigateToSignIn = false
    @EnvironmentObject var healthManager: HealthManager
    
    @Environment(\.presentationMode) var close
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("ListColor")
                    .ignoresSafeArea()
                VStack {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(Color("blackish"))
                        
                        HStack(alignment: .center){
                            VStack{
                                AsyncImage(url: URL(string: globalDataModel.userProfileImageUrl ?? "")) { image in
                                    
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                     
                                } placeholder: {
                                    ZStack {
                                        Circle().foregroundColor(.purple)
                                    }
                                }
                                .frame(width: 100, height: 100)
                                
                             
                            }
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text(globalDataModel.user?.name ?? "N/A")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(Color.white)
                                    
                                
                                Text("Miembro desde: \(globalDataModel.user?.creationDate ?? "today")")
                                    .font(.caption)
                                    .foregroundStyle(Color.white)
                                
                            }
                        }
                        .padding()
                        
                    }
                    .frame(height: 150)
                    .padding()
                    
                   
                    
                    
                    VStack(alignment: .leading){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.white)
                            
                            HStack{
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color("primaryShadow"))
                                    
                                    Image(systemName: "doc.text.image")
                                        .foregroundStyle(Color("Primary"))
                                        .font(.title3)
                                    
                                }
                                .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    
                                    Text("Edad")
                                        .bold()
                                        .font(.title3)
                                    if let birthdayData = healthManager.userHealthData["birthday"] {
                                        Text(birthdayData.amount)
                                            .bold()
                                            .font(.caption)
                                            .foregroundStyle(Color.gray)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing){
                                    if let ageData = healthManager.userHealthData["age"] {
                                        Text(ageData.amount)
                                            .bold()
                                            .font(.title2)
                                    }
                                    Text("años")
                                        .bold()
                                        .font(.callout)
                                }
                                
                               
                            }
                            .padding()
                            
                        }
                        .frame(height: 75)
                        .padding(.bottom)
                        
                        HStack{
                            VStack(alignment: .leading){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.white)
                                    
                                    HStack{
                                        ZStack{
                                            Circle()
                                                .foregroundStyle(Color("WarningBg"))
                                            
                                            Image(systemName: "figure.arms.open")
                                                .foregroundStyle(Color("Warning"))
                                                .font(.title3)
                                            
                                        }
                                        .frame(width: 50, height: 50)
                                        
                                        VStack(alignment: .leading){
                                            Text("Altura")
                                                .bold()
                                                .font(.title3)
                                            if let heightData = healthManager.userHealthData["height"] {
                                                Text("\(heightData.amount) cm")
                                                    .bold()
                                                    .font(.caption)
                                                    .foregroundStyle(Color.gray)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    
                                }
                                
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.white)
                                    
                                    HStack{
                                        ZStack{
                                            Circle()
                                                .foregroundStyle(Color("GreenBg"))
                                            
                                            Image(systemName: "dumbbell")
                                                .foregroundStyle(Color("GreenIcon"))
                                                .font(.title3)
                                            
                                        }
                                        .frame(width: 50, height: 50)
                                        
                                        VStack(alignment: .leading){
                                            Text("Peso")
                                                .bold()
                                                .font(.title3)
                                            if let weightData = healthManager.userHealthData["weight"] {
                                                Text("\(weightData.amount) kg")
                                                    .bold()
                                                    .font(.caption)
                                                    .foregroundStyle(Color.gray)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        
                                    }
                                    .padding()
                                    
                                }
                                
                            }
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.white)
                                VStack{
                                    HStack{
                                        
                                        ZStack{
                                            Circle()
                                                .foregroundStyle(Color("RedBg"))
                                            
                                            Image(systemName: "heart.fill")
                                                .foregroundStyle(Color("Red"))
                                                .font(.title3)
                                            
                                        }
                                        .frame(width: 50, height: 50)
                                        
                                        
                                        VStack(alignment: .leading){
                                            Text("Ritmo Cardiaco")
                                                .bold()
                                                .font(.headline)
                                     
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    Spacer()
                                    
                                    if let heartRateData = healthManager.userHealthData["heartRate"],
                                              let latestHeartRate = heartRateData.heartRateDataPoints?.last {
                                               Text("\(Int(latestHeartRate.value)) LPM")
                                                   .font(.title)
                                                   .bold()
                                           }
                                    
                                    Spacer()
                                }
                                .padding()
                            }
                            
                            .frame(maxHeight: .infinity)
                            
                            
                            
                            
                        }
                        .frame(height: 150)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.white)
                            
                            HStack{
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color("RedBg"))
                                    
                                    Image(systemName: "drop.fill")
                                        .foregroundStyle(Color("Red"))
                                        .font(.title3)
                                    
                                }
                                .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    Text("Tipo de Sangre")
                                        .bold()
                                        .font(.title3)
                                    
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing){
                                    if let bloodData = healthManager.userHealthData["bloodType"] {
                                        
                                        Text("\(bloodData.amount)")
                                            .bold()
                                            .font(.title2)
                                    }
                                
                                }
                                
                               
                            }
                            .padding()
                            
                        }
                        .frame(height: 75)
                        .padding(.vertical)
                        
                    }
                    .padding()
                    
                    
                    Button(action: {
                        NetworkManager.shared.signOut { result in
                            switch result {
                            case .success(_):
                                print("Logged out successfully")
                                // Assuming you want to navigate to the sign-in view upon successful logout:
                                self.navigateToSignIn = true
                            case .failure(let error):
                                print("Logout failed: \(error)")
                                // Handle the error accordingly
                            }
                        }
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20.0)
                                .foregroundStyle(Color("blackish"))
                            Text("Cerrar sesión")
                                .foregroundStyle(Color.white)
                        }
                        .frame(height: 60)
                        .padding()
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle("Mi Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action:{
                        close.wrappedValue.dismiss()
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                                .font(.callout)
                                .bold()
                            
                            
                        }
                        
                        
                    }
                }
            }
        }
        .onAppear {
            //healthManager.requestHealthKitAuthorization()
            healthManager.fetchHeartRateData()
                        healthManager.fetchBloodType()
                        healthManager.fetchHeight()
                        healthManager.fetchWeight()
                        healthManager.fetchGender()
                        healthManager.fetchAge()
                    }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .fullScreenCover(isPresented: $navigateToSignIn, content: {
            signIn()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

