//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

  let settingsButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: UIImage(named: "app_icon"))

  override init(frame: CGRect) {
    super.init(frame: frame)

    heightAnchor.constraint(equalToConstant: 80).isActive = true

    fireImageView.contentMode = .scaleAspectFit
    let settingsImage = UIImage(named: "top_left_profile")?.withRenderingMode(.alwaysOriginal)
    settingsButton.setImage(settingsImage, for: .normal)

    let messageImage = UIImage(named: "top_right_messages")?.withRenderingMode(.alwaysOriginal)
    messageButton.setImage(messageImage, for: .normal)

    [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach {
      addArrangedSubview($0)
    }

    distribution = .equalCentering
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  required init(coder: NSCoder) {
    fatalError()
  }
}
