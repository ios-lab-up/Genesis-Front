import SwiftUI
import CoreML

struct CameraView: View {
    @State private var showImagePicker = false
    @State private var showResultView = false
    @State private var resultText = ""

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
                        .background(Color.blue)
                        .cornerRadius(100)
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(analyzeImage: analyzeImage)
                }

                NavigationLink("", destination: resultsView(resultText: resultText), isActive: $showResultView)
            }
        }
    }

    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?.getCVPixelBuffer() else {
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try GoogLeNetPlaces(configuration: config)
            let input = GoogLeNetPlacesInput(sceneImage: buffer)

            let output = try model.prediction(input: input)
            let text = output.sceneLabel
            if let probability = output.sceneLabelProbs[text] {
                let percentage = Int(probability * 100)
                resultText = "\(text) (\(percentage)%)"
                showResultView = true // Esto activará la navegación a la nueva vista
            }
        } catch {
            print(error.localizedDescription)
        }
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
