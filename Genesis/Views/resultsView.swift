import SwiftUI

struct resultsView: View {
    let resultText: String
    let progressValue: Double
    
    let resultText2: String
    let progressValue2: Double
    
    let resultText3: String
    let progressValue3: Double

    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(Color("primaryShadow"))

                HStack{
                    VStack(alignment: .leading){
                        Text("Your results")

                        Text(resultText)
                            .font(.title)
                            .padding(.bottom, 1)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
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
                            
                            Text("Your \npredicton\npercentage")
                                .bold()
                            Spacer()
                            ZStack{
                                Circle()
                                    .frame(width: 40)
                                    .foregroundStyle(Color("circlePurple"))
                                Image(systemName: "info.circle")
                            }
                        }

                        

                        Text("\(Int(progressValue))%") // Texto del resultado
                                                    .font(.title)
                                                    .bold()
                                                    .padding(.top)
                                                    .padding(.bottom)



                    }
                    .padding()
                }

                .frame(width: 200, height: 200)
                
                
                VStack(alignment: .leading){
                    Text(resultText) // Texto del resultado
                        .font(.title3)
                        .bold()

                    ProgressView(value: progressValue, total: 100) // Barra de progreso
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                    
                    Text(resultText2) // Texto del resultado
                        .font(.title3)
                        .bold()

                    ProgressView(value: progressValue2, total: 100) // Barra de progreso
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                    
                    Text(resultText3) // Texto del resultado
                        .font(.title3)
                        .bold()

                    ProgressView(value: progressValue3, total: 100) // Barra de progreso
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("green")))
                }



            }
        }
        .padding()
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct resultsView_Previews: PreviewProvider {
    static var previews: some View {
        resultsView(resultText: "Melanoma", progressValue: 0.0, resultText2: "b", progressValue2: 0.0, resultText3: "c", progressValue3: 0.0)
    }
}
