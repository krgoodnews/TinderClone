//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class CardView: UIView {

  fileprivate let imageView = UIImageView(image: UIImage(named: "lady5c"))

  override init(frame: CGRect) {
    super.init(frame: frame)

    layer.cornerRadius = 10
    clipsToBounds = true

    addSubview(imageView)
    imageView.fillSuperview()

    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
  }

  @objc private func handlePan(gesture: UIPanGestureRecognizer) {

    switch gesture.state {
    case .changed:
      handleChanged(gesture: gesture)
    case .ended:
      UIView.animate(withDuration: 0.75,
              delay: 0,
              usingSpringWithDamping: 0.6,
              initialSpringVelocity: 0.1,
              options: .curveEaseOut,
              animations: {
        self.transform = .identity
      })
    default:
      ()
    }
  }

  private func handleChanged(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: nil)
    self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
