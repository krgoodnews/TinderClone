//
// Created by 국윤수 on 2019-06-27.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
  let title: String
  let brandName: String
  let posterPhotoName: String

  func toCardViewModel() -> CardViewModel {
    let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
    attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))

    return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedString, textAlignment: .center)
  }
}