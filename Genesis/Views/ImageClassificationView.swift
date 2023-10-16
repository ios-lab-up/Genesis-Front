import CoreML
import UIKit


func analyzeImage(image: UIImage) {
    
    guard let resizedImage = image.resize(to: CGSize(width: 224, height: 224)),
          let buffer = resizedImage.toCVPixelBuffer() else {
        
        return
    }
    
    do {
        let config = MLModelConfiguration()
        let model = try NanoChallenge_2(configuration: config)
        let input = NanoChallenge_2Input(image: buffer)
        
        let output = try model.prediction(input: input)
        
        let top3Predictions = Array(output.classLabelProbs.sorted(by: { $0.value > $1.value }).prefix(3))
        
        let firstPredictionLabel = top3Predictions[0].key
        let firstPredictionPercentage = Int(top3Predictions[0].value * 100)
        
        let secondPredictionLabel = top3Predictions[1].key
        let secondPredictionPercentage = Int(top3Predictions[1].value * 100)
        
        let thirdPredictionLabel = top3Predictions[2].key
        let thirdPredictionPercentage = Int(top3Predictions[2].value * 100)
        
        print("1. \(firstPredictionLabel): \(firstPredictionPercentage)%")
        print("2. \(secondPredictionLabel): \(secondPredictionPercentage)%")
        print("3. \(thirdPredictionLabel): \(thirdPredictionPercentage)%")
        
        
        
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
