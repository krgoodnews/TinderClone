//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
  let name: String
  let age: Int
  let profession: String
  let imageNames: [String]

  func toCardViewModel() -> CardViewModel {

    let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    attributedText.append(NSMutableAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
    attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))

    return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
  }
}

