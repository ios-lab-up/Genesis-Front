//
//  NewPatientDetailsView.swift
//  DermAware
//
//  Created by Luis Cedillo M on 25/11/23.
//



import SwiftUI

struct NewPatientDetailsView: View {
    var body: some View {
        VStack{
            Circle()
                .fill(.gray)
                .frame(width: 170)
                .padding(.trailing)
            Text("Ivan Cruz")
                .font(.system(size: 24, weight: .semibold))
            Text("ivan.cruz@example.com")
                .font(.system(size: 24))
            Spacer()
            ScrollView(.horizontal, showsIndicators: false){
                RoundedRectangle(cornerRadius: 22)
                    .fill(.gray)
                    .frame(width: 135, height: 135, alignment: .trailing)
            }
            .padding()
            Spacer()
            
            
            
        }
        
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NewPatientDetailsView()
}
