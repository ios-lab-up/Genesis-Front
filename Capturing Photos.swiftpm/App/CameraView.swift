import SwiftUI
import CoreML

/*
 struct CameraView: View {
 @StateObject private var model = DataModel()
 @State private var showResultView = false
 @State private var analysisResult: String = ""
 
 private static let barHeightFactor = 0.15
 
 var body: some View {
 NavigationStack {
 GeometryReader { geometry in
 ViewfinderView(image: $model.viewfinderImage)
 .overlay(alignment: .bottom) {
 buttonsView()
 .frame(height: geometry.size.height * Self.barHeightFactor)
 .background(.black.opacity(0.75))
 }
 .overlay(alignment: .topTrailing) {
 Button {
 model.camera.switchCaptureDevice()
 } label: {
 Label("", systemImage: "arrow.triangle.2.circlepath")
 .font(.system(size: 26, weight: .bold))
 .foregroundColor(.white)
 .padding(.top, 20)
 }
 .padding()
 }
 .overlay(alignment: .center) {
 Color.clear
 .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
 .accessibilityElement()
 .accessibilityLabel("View Finder")
 .accessibilityAddTraits([.isImage])
 }
 .background(.black)
 }
 .toolbar(.hidden, for: .tabBar)
 .task {
 await model.camera.start()
 await model.loadPhotos()
 await model.loadThumbnail()
 }
 .navigationTitle("Camera")
 .navigationBarTitleDisplayMode(.inline)
 .navigationBarHidden(true)
 .ignoresSafeArea()
 .statusBar(hidden: true)
 }
 }
 
 private func buttonsView() -> some View {
 VStack {
 Spacer()
 
 ZStack {
 ZStack{
 RoundedRectangle(cornerRadius: 20)
 .frame(height: 350) // Aumenta la altura del cuadro desenfocado
 .offset(y: -70) // Desplaza el cuadro desenfocado más arriba
 .background(.ultraThinMaterial)
 .cornerRadius(20)
 
 Text("Make sure the image is clear and close")
 .foregroundStyle(.black)
 }
 
 RoundedRectangle(cornerRadius: 20)
 .frame(height: 200) // Aumenta la altura del cuadro blanco
 .foregroundColor(.white)
 .cornerRadius(20)
 
 HStack(spacing: 10) {
 NavigationLink {
 PhotoCollectionView(photoCollection: model.photoCollection)
 .onAppear {
 model.camera.isPreviewPaused = true
 }
 .onDisappear {
 model.camera.isPreviewPaused = false
 }
 } label: {
 Label {
 Text("Gallery")
 } icon: {
 ThumbnailView(image: model.thumbnailImage)
 }
 }
 
 Button(action: {
 if let uiImage = model.viewfinderImage.uiImage {
 analyzeImage(image: uiImage)
 }
 model.camera.takePhoto()
 }) {
 Text("Take photo")
 .font(.headline)
 .foregroundColor(.white)
 .frame(maxWidth: .infinity)
 .padding(.vertical, 25)
 .background(Color("Primary"))
 .cornerRadius(100)
 }
 .background(NavigationLink("", destination: ResultView(result: $analysisResult), isActive: $showResultView))
 }
 }
 .buttonStyle(.plain)
 .labelStyle(.iconOnly)
 }
 
 func analyzeImage(image: UIImage) {
 guard let buffer = image.resize(size: CGSize(width: 224, height: 224))?.getCVPixelBuffer() else {
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
 analysisResult = "\(text) (\(percentage)%)"
 } else {
 analysisResult = text
 }
 showResultView = true
 }
 catch {
 print(error.localizedDescription)
 }
 }
 }
 
 struct ResultView: View {
 @Binding var result: String
 
 var body: some View {
 Text(result)
 .font(.largeTitle)
 .padding()
 }
 }
 
 }
 
 */
