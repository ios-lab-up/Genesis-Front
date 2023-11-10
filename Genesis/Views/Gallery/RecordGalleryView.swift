//
//  RecordGalleryView.swift
//  Genesis
//
//  Created by Luis Cedillo M on 09/11/23.
//
import SwiftUI

struct FullScreenImageView: View {
    var image: Image
    var dismissAction: () -> Void // Closure to call when dismissing the view

    // State to track the drag offset
    @State private var dragOffset = CGSize.zero

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .offset(y: dragOffset.height) // Apply the vertical offset
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        // Update the dragOffset state
                        self.dragOffset = gesture.translation
                    }
                    .onEnded { gesture in
                        // If drag distance is significant, dismiss the view
                        if abs(gesture.translation.height) > 100 {
                            dismissAction()
                        }
                        // Reset the dragOffset state
                        self.dragOffset = .zero
                    }
            )
            .animation(.spring(), value: dragOffset)
    }
}


struct RecordGalleryView: View {
    @Namespace var namespace
    var imageDataList: [ImageData] // your image data array
    
    @State private var selectedItem: ImageData?
    @State private var position = CGSize.zero
    @State private var showFullScreen = false // New state variable for full-screen presentation

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)],
                          spacing: 2) {
                    ForEach(imageDataList, id: \.id) { item in
                        if let imageData = Foundation.Data(base64Encoded: item.image),
                           let uiImage = UIImage(data: imageData) {
                            // Use the image here
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .onTapGesture {
                                                self.selectedItem = item
                                                self.showFullScreen = true // Indicate that full-screen view should be shown
                                            }
                            
                        } else {
                            Text("Image not available")
                                // display an error placeholder
                        }
                    }
                }
                .padding(2)
            }
            
            // White overlay that will appear when an item is selected
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(selectedItem == nil ? 0 : min(1, max(0, 1 - abs(Double(position.height) / 800))))
            
            // Display the selected item in a larger view when tapped
            if let selectedItem = selectedItem {
                // Corrected optional binding syntax
                ZoomableScrollView {
                    
                    Image(uiImage: UIImage(data: Data(base64Encoded: selectedItem.image) ?? Data())!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .matchedGeometryEffect(
                            id: selectedItem.id,
                            in: namespace,
                            isSource: self.selectedItem != nil
                        )
                        .zIndex(2)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                self.selectedItem = nil // Dismiss the view
                            }
                        }
                        .offset(position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.position = value.translation
                                }
                                .onEnded { value in // This is where .onEnded is used
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                        // Determine if the drag was significant enough to dismiss the view
                                        if 200 < abs(self.position.height) {
                                            self.selectedItem = nil
                                        }
                                        self.position = .zero // Always reset the position after the drag ends
                                    }
                                }
                        )
                    
                }
            }


        }
    }
}
