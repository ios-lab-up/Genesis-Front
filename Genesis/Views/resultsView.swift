import SwiftUI




struct resultsView: View {
    
    @ObservedObject var globalDataModel = GlobalDataModel.shared
    @Environment(\.presentationMode) var close
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(Color("primaryShadow"))

                    HStack{
                        VStack(alignment: .leading){
                            Text("Tus Resultados")

                            Text(globalDataModel.userImages.last?.mlDiagnostic.first?.sickness ?? "N/A")
                                .font(.title)
                                .padding(.bottom, 1)
                            Text("Clasificaciones dermatológicas basadas en análisis probabilístico mediante modelo de aprendizaje automático.")
                                .font(.footnote)
                        }
                        .frame(width: 150)

                        Spacer()

                        ZStack{
                            Circle()
                                .frame(width: 140)
                                .foregroundStyle(Color("circlePurple"))

                            Image(systemName: "figure.arms.open")
                                .foregroundStyle(Color("iconPurpe"))
                                .font(.system(size: 60))
                        }
                    }
                    .padding()

                }.frame(height: 400)


                HStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(Color("primaryShadow"))


                        VStack(alignment: .leading){
                            
                            HStack{
                                
                                Text("Tu \npredicción")
                                    .bold()
                                Spacer()
                                ZStack{
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundStyle(Color("circlePurple"))
                                    Image(systemName: "info.circle")
                                }
                            }

                            

                            Text("") // Texto del resultado
                                                        .font(.title)
                                                        .bold()
                                                        .padding(.top)
                                                        .padding(.bottom)



                        }
                        .padding()
                    }

                    .frame(width: 200, height: 200)
                    
                    
                    VStack(alignment: .leading){
                        Text(globalDataModel.userImages.last?.mlDiagnostic.first?.sickness ?? "N/A") // TextoN del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: (globalDataModel.userImages.last?.mlDiagnostic.first?.precision ?? 0.0) * 100.0, total: 100) // Barra de progreso
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                        
                        Text(globalDataModel.userImages.last?.mlDiagnostic[1].sickness ?? "N/A") // Texto del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: (globalDataModel.userImages.last?.mlDiagnostic[1].precision ?? 0.0) * 100.0, total: 100) // Barra de progreso
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                        
                        Text(globalDataModel.userImages.last?.mlDiagnostic.last?.sickness ?? "N/A") // Texto del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: (globalDataModel.userImages.last?.mlDiagnostic.last?.precision ?? 0.0) * 100.0, total: 100) // Barra de progreso
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                    }



                }
            }
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.large)
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
    }
    
}



