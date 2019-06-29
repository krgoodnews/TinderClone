//
// Created by 국윤수 on 2019-06-27.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
  func toCardViewModel() -> CardViewModel
}

struct CardViewModel {

  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment
}
