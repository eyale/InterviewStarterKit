//
//  UIImageView.swift
//  InterviewStarterKit
//
//  Created by Anton Honcharov on 3/29/21.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
  func load(from url: String) {
    if let image = imageCache.object(forKey: url as NSString) as? UIImage {
      self.image = image
      return
    }
    guard let imageURL = URL(string: url) else {
      print("can't load image \n")
      return
    }

    DispatchQueue.global().async { [weak self] in
      guard let `self` = self else { return }
      guard let data = try? Data(contentsOf: imageURL) else { return }

      if let image = UIImage(data: data) {
        DispatchQueue.main.async {
          imageCache.setObject(image, forKey: url as NSString)
          self.image = image
        }
      }
    }
  }
}
