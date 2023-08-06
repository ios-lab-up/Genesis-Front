import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()

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
                }

                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 200) // Aumenta la altura del cuadro blanco
                    .foregroundColor(.white)
                    .cornerRadius(20)

                HStack(spacing: 60) {
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

                    Button {
                        model.camera.takePhoto()
                    } label: {
                        Label {
                            Text("Take Photo")
                        } icon: {
                            ZStack {
                                Circle()
                                    .strokeBorder(Color("Primary"), lineWidth: 3)
                                    .frame(width: 62, height: 62)
                                Circle()
                                    .fill(Color("Primary"))
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
    }
}
