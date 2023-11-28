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

                            Text("resultText")
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
                                
                                Text("Tu \npredicción\nporcentaje")
                                    .bold()
                                Spacer()
                                ZStack{
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundStyle(Color("circlePurple"))
                                    Image(systemName: "info.circle")
                                }
                            }

                            

                            Text("Int(progressValue)%") // Texto del resultado
                                                        .font(.title)
                                                        .bold()
                                                        .padding(.top)
                                                        .padding(.bottom)



                        }
                        .padding()
                    }

                    .frame(width: 200, height: 200)
                    
                    
                    VStack(alignment: .leading){
                        Text(globalDataModel.userImages.) // Texto del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: 50, total: 100) // Barra de progreso
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                        
                        Text("resultText2") // Texto del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: 50, total: 100) // Barra de progreso
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                        
                        Text("resultText3") // Texto del resultado
                            .font(.title3)
                            .bold()

                        ProgressView(value: 50, total: 100) // Barra de progreso
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



func findHighestPrecisionDiagnosis(in diagnostics: [Diagnostic]) -> Diagnostic? {
    return diagnostics.max(by: { $0.precision < $1.precision })
}
