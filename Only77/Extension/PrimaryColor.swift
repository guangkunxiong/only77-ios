//
//  PrimaryColor.swift
//  Only77
//
//  Created by yukun xie on 2024/4/5.
//

import Foundation
import UIKit
import DominantColor


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
}

func getColorFormImage(image:UIImage) ->UIColor{
    let dominantColors = image.dominantColors()
    let color = dominantColors.first ?? UIColor.white
    return compareColor(color: color)
}

func compareColor(color: UIColor) -> UIColor {
    let colors: [UIColor]=[UIColor(hex:"#F8ECD1" ),UIColor(hex:"#F9CEEE" ),UIColor(hex:"#F1DDBF" ),UIColor(hex:"#F8ECD1" ),UIColor(hex:"#525E75" )]
    var minDistance = Double.infinity
    var closestColor = UIColor()
    
    for compareColor in colors {
        let distance = colorDistance(color1: color, color2: compareColor)
        if distance < minDistance {
            minDistance = distance
            closestColor = compareColor
        }
    }
    
    return closestColor
}

func colorDistance(color1: UIColor, color2: UIColor) -> Double {
    let color1Components = color1.cgColor.components ?? [0, 0, 0, 0]
    let color2Components = color2.cgColor.components ?? [0, 0, 0, 0]
    
    let r = pow(Double(color1Components[0] - color2Components[0]), 2)
    let g = pow(Double(color1Components[1] - color2Components[1]), 2)
    let b = pow(Double(color1Components[2] - color2Components[2]), 2)
    
    return sqrt(r + g + b)
}
