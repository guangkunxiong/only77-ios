//
//  OrientationManager.swift
//  Only77
//
//  Created by yukun xie on 2024/2/7.
//
import SwiftUI
import Combine
import Foundation

class OrientationManager: ObservableObject {
    @Published var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { notification in
                UIDevice.current.orientation
            }
            .assign(to: \.deviceOrientation, on: self)
            .store(in: &cancellables)
    }
}
