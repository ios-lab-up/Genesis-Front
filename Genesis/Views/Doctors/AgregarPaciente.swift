//
//  AddPatientsView.swift
//  DermAware
//
//  Created by Sara Miranda on 26/11/23.
//

//
//  AddPatientView.swift
//  DermAware
//
//  Created by Mauricio Pérez on 25/11/23.
//

import SwiftUI

struct AgregarPacienteView: View {
    @State private var searchText = ""
    let name_patients = ["Sara Miranda", "Luis Cedillo", "Mauricio Pérez", "Lorenzo Reinoso"]
    
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Agregar Paciente")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.leading,30)
                Spacer()
            }
            
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }.padding(.leading, 30)
                .padding(.trailing, 30)
            
            Spacer()
            Spacer()
            //patients
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(searchResults, id: \.self) { patient_name in
                       
                            PatientCardView(name: patient_name)
                        }
                    }
                    
                    // To make the ZStack take the full width minus some padding
                    .padding(.horizontal)
                    .navigationTitle("Pacientes")
                    Spacer()
                }
            }.navigationBarTitle("Pacientes", displayMode: .inline)
        }
    var searchResults: [String] {
        if searchText.isEmpty {
                    return name_patients
                } else {
                    return name_patients.filter { $0.lowercased().contains(searchText.lowercased()) }
                }
        }
    }
    

struct PatientCardView: View {
    let name: String
    var body: some View {
        ZStack {
            HStack {
                Image("imagenPaciente") // Replace with your actual image resource
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 10)
                    .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 27, weight: .semibold))
                        .padding(.bottom, 10)
                    Text("     21.11.2023")
                        .font(.system(size: 16))
                    Text("     Melanoma")
                        .font(.system(size: 16))
                    Text(" ")
                    NavigationLink(destination: ScheduleView()) {
                        Text("Detalles")
                            .font(.system(size: 20))
                            .foregroundColor(Color("blackish")) // Use foregroundColor for text color
                            .padding()
                            .background(Color("yellowsito"))
                            .clipShape(Capsule())
                    }
                    .padding(.leading, 30)
                }
                .foregroundColor(.white)
                Spacer() // Ensure the HStack contents are aligned to the left
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .background(Color("blackish"))
            .cornerRadius(22)
        }
    }
}

#Preview {
    AgregarPacienteView()
}

