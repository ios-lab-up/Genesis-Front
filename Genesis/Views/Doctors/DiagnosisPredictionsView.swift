//
//  DiagnosisPredictionsView.swift
//  DermAware
//
//  Created by Mauricio Pérez on 26/11/23.
//

import SwiftUI

struct DiagnosisPredictionsView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("skinSample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 336, height: 336)
                .clipShape(Rectangle())
                .clipShape(RoundedRectangle(cornerRadius: 22))
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color("yellowsito"))
                        .frame(width: 213, height: 120)
                        .opacity(0.4)
                    VStack(alignment: .leading){
                        Text("1. Diagnosis - 80%")
                        Text("2. Diagnosis - 15%")
                        Text("3. Diagnosis - 5%")
                    }
                        .font(.system(size: 20, weight: .semibold))
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color("purplit"))
                        .frame(width: 103, height: 120)
                        .opacity(0.4)
                    Text("21 de\nnov,\n2023")
                        .font(.system(size: 20, weight: .semibold))
                }
            }
            Spacer()
            NavigationLink(destination:PrescriptionDetailsView()){
                Text("Agendar cita")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.white))
                    .padding()
                    .padding(.horizontal, 25)
                    .background(Color("blackish"))
                    .clipShape(RoundedRectangle(cornerRadius: 22))
            }

        }
        .navigationTitle("Sara Miranda")
    }
}

#Preview {
    DiagnosisPredictionsView()
}
