//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    distribution = .fillEqually
    heightAnchor.constraint(equalToConstant: 120).isActive = true

    let subviews: [UIView] = [UIImage(named: "refresh_circle"),
     UIImage(named: "dismiss_circle"),
     UIImage(named: "super_like_circle"),
     UIImage(named: "like_circle"),
     UIImage(named: "boost_circle")].map {
      let button = UIButton(type: .system)
      button.setImage($0?.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
    }

    subviews.forEach {
      addArrangedSubview($0)
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
