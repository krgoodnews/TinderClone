//
// Created by 국윤수 on 2019-06-30.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

  let padding: CGFloat
  let height: CGFloat

  init(padding: CGFloat = 24, height: CGFloat = 50) {
    self.padding = padding
    self.height = height

    super.init(frame: .zero)
    self.layer.cornerRadius = height / 2
    self.backgroundColor = .white
    invalidateIntrinsicContentSize()
  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }

  override var intrinsicContentSize: CGSize {
    return .init(width: 0, height: height)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

