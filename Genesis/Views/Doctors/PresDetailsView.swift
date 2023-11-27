//
//  PresDetailsView.swift
//  DermAware
//
//  Created by Mauricio Pérez on 26/11/23.
//

import SwiftUI

struct PresDetailsView: View {
    @State var name = ""
    @State var dias = 1
    @State var horas = 1
    @State var comments = ""
    var body: some View {
        VStack(alignment: .leading){
            Text("Medicamento:")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            TextField("Nombre del medicamento", text: $name)
                .font(.system(size: 16))
                .padding()
                .border(Color("bluey"), width: 2)
            
            Text("Cada:")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            HStack{
                Button("-"){
                    if self.horas > 1{
                        self.horas -= 1
                    }
                }
                .padding()
                .foregroundColor(Color(.black))
                .background(Color("yellowsito"))
                .clipShape(Circle())
                Text("\(horas)")
                    .bold()
                    .font(.system(size: 24))
                Text("horas")
                Button("+"){
                    self.horas += 1
                }
                .padding()
                .foregroundColor(Color(.black))
                .background(Color("yellowsito"))
                .clipShape(Circle())
            }
            
            Text("Días:")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            HStack {
                Button("-"){
                    if self.dias > 1{
                        self.dias -= 1
                    }
                }
                .padding()
                .foregroundColor(Color(.black))
                .background(Color("purplit"))
                .clipShape(Circle())
                Text("\(dias)")
                    .bold()
                    .font(.system(size: 24))
                Button("+"){
                    self.dias += 1
                }
                .padding()
                .foregroundColor(Color(.black))
                .background(Color("purplit"))
                .clipShape(Circle())
            }
            
            Text("Comentarios:")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            TextField("Notas importantes", text: $comments, axis: .vertical)
                .font(.system(size: 16))
                .padding()
                .border(Color("bluey"), width: 2)
            Spacer()
            }
        .padding()
        
        
        NavigationLink(destination: DoctorDashboardView()){
            Text("Agendar cita")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color(.white))
                .padding()
                .padding(.horizontal, 25)
                .background(Color("blackish"))
                .clipShape(RoundedRectangle(cornerRadius: 22))
            
        }
        .padding()
        .navigationTitle("Receta")
        
    }
}

#Preview {
    PresDetailsView()
}
