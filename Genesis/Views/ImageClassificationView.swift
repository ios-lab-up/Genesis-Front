import SwiftUI
import CoreML

struct CameraView: View {
    @State private var showImagePicker = false
    @State private var resultText1 = ""
    @State private var resultPercent1 = 0.0
    @State private var resultText2 = ""
    @State private var resultPercent2 = 0.0
    @State private var resultText3 = ""
    @State private var resultPercent3 = 0.0
    @State private var isActive = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Select Image")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .background(Color("Primary"))
                        .cornerRadius(100)
                }
                .padding()
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(analyzeImage: analyzeImage)
                }

                NavigationLink(destination: resultsView(resultText: resultText1, progressValue: resultPercent1, resultText2: resultText2, progressValue2: resultPercent2, resultText3: resultText3, progressValue3: resultPercent3), isActive: $isActive) {
                    EmptyView()
                }
            }
        }
    }
    
    
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?.getCVPixelBuffer() else {
            return
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try NanoChallenge_2(configuration: config)
            let input = NanoChallenge_2Input(image: buffer)
            
            let output = try model.prediction(input: input)
            
            // Obtener los tres valores más coincidentes
            let top3Predictions = Array(output.classLabelProbs.sorted(by: { $0.value > $1.value }).prefix(3))
            
            // Puedes acceder a las etiquetas y probabilidades de las tres mejores predicciones como sigue:
            let firstPredictionLabel = top3Predictions[0].key
            let firstPredictionPercentage = Int(top3Predictions[0].value * 100)
            
            let secondPredictionLabel = top3Predictions[1].key
            let secondPredictionPercentage = Int(top3Predictions[1].value * 100)
            
            let thirdPredictionLabel = top3Predictions[2].key
            let thirdPredictionPercentage = Int(top3Predictions[2].value * 100)
            
            // Aquí puedes asignar estos valores a las variables de estado o hacer lo que necesites con ellos
            resultText1 = "\(firstPredictionLabel)"
            resultPercent1 = Double(firstPredictionPercentage)
            resultText2 = "\(secondPredictionLabel)"
            resultPercent2 = Double(secondPredictionPercentage)
            resultText3 = "\(thirdPredictionLabel)"
            resultPercent3 = Double(thirdPredictionPercentage)// Puedes ajustar esto según tus necesidades
            isActive = true // Esto activará la navegación a la nueva vista
        } catch {
            print(error.localizedDescription)
        }
    }
    
    struct ResultView: View {
        let resultText: String
        
        var body: some View {
            Text(resultText)
                .padding()
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        let analyzeImage: (UIImage?) -> Void
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.analyzeImage(image)
                }
                picker.dismiss(animated: true)
            }
        }
    }
    
}
