import CoreML
import UIKit


func analyzeImage(image: UIImage) {
    
    guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)),
          let buffer = resizedImage.toCVPixelBuffer() else {
        print("Failed to prepare image for analysis.")
        return
    }
    
    // Convert UIImage to Data
    guard let imageData = resizedImage.jpegData(compressionQuality: 0.7) else { // or use resizedImage.pngData() if PNG format is needed
        print("Failed to convert image to data.")
        return
    }
    
    do {
        let config = MLModelConfiguration()
        let model = try NanoChallenge_2(configuration: config)
        let input = NanoChallenge_2Input(image: buffer)
        
        let output = try model.prediction(input: input)
        
        let top3Predictions = Array(output.classLabelProbs.sorted(by: { $0.value > $1.value }).prefix(3))
        
        // Print top 3 predictions for debugging purposes
        for (index, prediction) in top3Predictions.enumerated() {
            let label = prediction.key
            let percentage = Int(prediction.value * 100)
            print("\(index + 1). \(label): \(percentage)%")
        }
        
        // Call the uploadDiagnosticImage function
        uploadDiagnosticImage(imageData: imageData, top3Predictions: top3Predictions) { result in
            switch result {
            case .success(let response):
                print("Success: \(response)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    } catch {
        print(error.localizedDescription)
    }
}


extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(self.size.width),
                                         Int(self.size.height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs,
                                         &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}

struct Prediction: Codable {
    let sickness: String
    let precision: Double
}


func uploadDiagnosticImage(imageData: Data, top3Predictions: [(key: String, value: Double)], completion: @escaping (Result<Response<ImageData>, Error>) -> Void) {
    // Ensure there are at least three predictions
    guard top3Predictions.count >= 3 else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not enough predictions"])))
        return
    }

    // Create Prediction instances
    let firstPrediction = Prediction(sickness: top3Predictions[0].key, precision: top3Predictions[0].value)
    let secondPrediction = Prediction(sickness: top3Predictions[1].key, precision: top3Predictions[1].value)
    let thirdPrediction = Prediction(sickness: top3Predictions[2].key, precision: top3Predictions[2].value)

    let predictions = [firstPrediction, secondPrediction, thirdPrediction]

    // Convert predictions to JSON string
    var diagnostic: String?
    do {
        let jsonData = try JSONEncoder().encode(predictions)
        diagnostic = String(data: jsonData, encoding: .utf8)
    } catch {
        print("Error encoding JSON: \(error)")
        completion(.failure(error))
        return
    }

    // Ensure diagnostic data is not nil
    guard let diagnosticData = diagnostic else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Diagnostic data is missing"])))
        return
    }

    // Call the upload function
    NetworkManager.shared.uploadImage(imageData: imageData, diagnostic: diagnosticData, completion: completion)
}

