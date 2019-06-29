//
// Created by 국윤수 on 2019-06-27.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
  func toCardViewModel() -> CardViewModel
}

// View Model is supposed refresent the State of our View
class CardViewModel {
  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment

  init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
    self.imageNames = imageNames
    self.attributedString = attributedString
    self.textAlignment = textAlignment
  }

  private var imageIndex = 0 {
    didSet {
      let imageName = imageNames[imageIndex]
      let image = UIImage(named: imageName)
      imageIndexObserver?(imageIndex, image)
    }
  }

  // Reactive Programming

  var imageIndexObserver: ((Int, UIImage?) -> ())?

  func advanceToNextPhoto() {
    imageIndex = min(imageIndex + 1, imageNames.count - 1)
  }

  func goToPreviousPhoto() {
    imageIndex = max(0, imageIndex - 1)
  }
}
