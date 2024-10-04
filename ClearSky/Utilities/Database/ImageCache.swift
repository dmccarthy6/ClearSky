//
//  ImageCache.swift
//  ClearSky
//
//  Created by Dylan  on 10/4/24.
//

import Foundation
import UIKit

final class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    func store(image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }

    func retrieve(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
}
