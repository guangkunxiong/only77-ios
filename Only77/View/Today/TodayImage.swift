//
//  DodayImage.swift
//  Only77
//
//  Created by yukun xie on 2024/3/31.
//

import Foundation
import SwiftUI
import Photos


func GetDayImgae() async->[UIImageColor] {
    var images = [UIImageColor]()
       let fetchOptions = PHFetchOptions()
       fetchOptions.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
           NSPredicate(format: "creationDate >= %@", Date().startOfDay as NSDate),
//           NSPredicate(format: "mediaSubtype & %d != 0 || mediaSubtype & %d != 0", PHAssetMediaSubtype.photoLive.rawValue, PHAssetMediaSubtype.photoHDR.rawValue)
       ])
       fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

       let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

       for i in 0..<fetchResult.count {
           let asset = fetchResult.object(at: i)
           if let image = await requestImage(for: asset) {
               images.append(UIImageColor(Image: image, Color: getColorFormImage(image: image)))
           }
       }
       return images
}


func requestImage(for asset: PHAsset) async -> UIImage? {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    option.isSynchronous = true
    return await withCheckedContinuation { continuation in
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option) { image, _ in
            continuation.resume(returning: image)
        }
    }
}
