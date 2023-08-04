//
//  ImageClassificationView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 03/08/23.
//

import SwiftUI
import CoreML
import Vision

struct ImageClassificationView: View {
    @State private var image: UIImage?
    @State private var classificationLabel: String = "Select an image for classification"
    @State private var isShowingImagePicker = false

    var body: some View {
        VStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
            }

            Button(action: {
                image = nil
                classificationLabel = "Select an image for classification"
            }) {
                Text("Clear Image")
            }

            Text(classificationLabel)
                .padding()

            Button(action: {
                isShowingImagePicker = true
            }) {
                Text("Select Image")
            }
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$image)
            }
        }
    }

    func loadImage() {
        guard let inputImage = image else { return }
        classify(image: inputImage)
    }

    func classify(image: UIImage) {
        let configuration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: GenesisAnalysisClassifier(configuration: configuration).model) else {
            fatalError("Failed to load model")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let results = request.results as? [VNClassificationObservation] {
                let topResult = results.first
                DispatchQueue.main.async {
                    classificationLabel = "\(topResult?.identifier ?? "Unknown") \(Int(topResult?.confidence ?? 0 * 100))% confidence"
                }
            }
        }

        if let ciImage = CIImage(image: image) {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("Failed to perform classification: \(error)")
                }
            }
        }
    }


}

