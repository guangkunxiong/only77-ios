//
//  UIImage.swift
//  Only77
//
//  Created by yukun xie on 2024/2/9.
//

import Foundation
import SwiftUI
import UIKit

extension UIImage {
    var dominantColor: UIColor? {
        guard let cgImage = cgImage else { return nil }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))

        guard let pixelBuffer = context?.data else { return nil }

        let pixelData = pixelBuffer.bindMemory(to: UInt8.self, capacity: 4)

        let r = CGFloat(pixelData[2]) / 255
        let g = CGFloat(pixelData[1]) / 255
        let b = CGFloat(pixelData[0]) / 255

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

