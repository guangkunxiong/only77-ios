//
//  Photo.swift
//  Only77
//
//  Created by yukun xie on 2024/2/1.
//

import Foundation
import UIKit

struct Photos{
    var PhtotoList:[Photo]
    var CoverUrl:String
    var Like:Int
}

struct Photo{
    var Id:Int
    var Url:String
    var Name:String
    var ZipUrl:String
}

struct UIImageColor{
    var Image:UIImage
    var Color:UIColor
}
