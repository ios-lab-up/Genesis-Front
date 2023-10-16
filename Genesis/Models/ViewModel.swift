//
//  ViewModel.swift
//  Genesis
//
//  Created by Iñaki Sigüenza on 11/10/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("Este dispositivo no tiene camara")
                return
            }
        }
        showPicker = true
    }
}
