//
//  lottieView.swift
//
//
//  Created by Iñaki Sigüenza on 31/10/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        
        DotLottieFile.loadedFrom(url: url) { result in
            switch result {
            case .success(let success):
                animationView.loadAnimation(from: success)
                animationView.loopMode = .loop
                animationView.play()
                
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
}
