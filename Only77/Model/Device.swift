//
//  Device.swift
//  Only77
//
//  Created by yukun xie on 2024/2/3.
//

import Foundation
import UIKit

enum Device {
    //MARK:当前设备类型 iphone ipad mac
    enum Devicetype{
        case iphone,ipad,mac
    }
    
    static var deviceType:Devicetype{
#if os(macOS)
        return .mac
#else
        if  UIDevice.current.userInterfaceIdiom == .pad {
            return .ipad
        }
        else {
            return .iphone
        }
#endif
    }}
