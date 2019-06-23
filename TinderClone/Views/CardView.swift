//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  private let threshold: CGFloat = 100

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
      handleChanged(gesture)
    case .ended:
      handleEnded(gesture)
    default:
      ()
    }
  }

  private func handleChanged(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: nil)

    // rotation
    let degrees: CGFloat = translation.x / 20
    let angle = degrees * .pi / 180
    let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
    self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
  }

  private func handleEnded(_ gesture: UIPanGestureRecognizer) {

    let shouldDismissCard = gesture.translation(in: nil).x > threshold

    UIView.animate(withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1,
            options: .curveEaseOut,
            animations: {
              if shouldDismissCard {
                self.frame = .init(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
              } else  {
                self.transform = .identity
              }
            }) { _ in
      self.transform = .identity
      self.frame = .init(x: 0, y: 0,
              width: self.superview!.frame.width,
              height: self.superview!.frame.height)
    }
  }


  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
