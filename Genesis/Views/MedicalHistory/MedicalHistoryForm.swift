//
//  MedicalHistoryForm.swift
//  Genesis
//
//  Created by Luis Cedillo M on 18/10/23.
//

import SwiftUI

struct MedicalHistoryForm: View {
    
    enum FocuesField{
        case Treatment, Indications, Dosage, FrecuencyValue, FrecuencyUnit, StartDate, EndDate
    }

    @State private var Treatment = ""
    @State private var Indications = ""
    @State private var Dosage = ""
    @State private var FrequencyValue = ""
    @State private var FrecuencyUnit = ""
    @State private var StartDate = ""
    @State private var EndDate = ""

    @FocusState private var fieldFocus: FocuesField?
    
    
    var body: some View {
        NavigationView{
            Form{
            
                
                Section("Treatment Details"){
                    
                    TextField("Treatment", text: $Treatment)
                        .focused($fieldFocus, equals: .Treatment)
                        .textContentType(.name)
                        .submitLabel(.next)
                    TextField("Indications", text: $Indications)
                        .focused($fieldFocus, equals: .Indications)
                        .submitLabel(.next)
                    
                }
                
                
                Section("Dosage Details"){
                    TextField("Dosage", text: $Dosage)
                        .focused($fieldFocus, equals: .Dosage)
                        .submitLabel(.next)
                    
                    TextField("Frecuency Value", text: $FrequencyValue)
                        .focused($fieldFocus, equals: .FrecuencyValue)
                        .submitLabel(.next)
                    
                    TextField("Frecuency Unit", text: $FrecuencyUnit)}
                    .focused($fieldFocus, equals: .Treatment)
                    .submitLabel(.next)
                
                Section("Time Range"){
                    TextField("Start Date", text: $StartDate)
                        .focused($fieldFocus, equals: .Treatment)
                        .textContentType(.dateTime)
                        .submitLabel(.next)
                    
                    TextField("End Date", text: $EndDate)
                        .focused($fieldFocus, equals: .Treatment)
                        .textContentType(.dateTime)
                        .submitLabel(.next)
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Prescription")
        }
    }
}

#Preview {
    MedicalHistoryForm()
}
