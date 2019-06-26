//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class CardView: UIView {

  var cardViewModel: CardViewModel? {
    didSet {
      imageView.image = UIImage(named: cardViewModel?.imageName ?? "")
      informationLabel.attributedText = cardViewModel?.attributedString
      informationLabel.textAlignment = cardViewModel?.textAlignment ?? .left
    }
  }

  private let threshold: CGFloat = 100

  fileprivate let imageView = UIImageView(image: UIImage(named: "lady5c"))
  fileprivate let informationLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    layer.cornerRadius = 10
    clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    addSubview(imageView)
    imageView.fillSuperview()

    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    informationLabel.text = "TEST NAME TEST NAME TEST AGE"
    informationLabel.textColor = .white
    informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
    informationLabel.numberOfLines = 0

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

    let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
    let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold

    UIView.animate(withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1,
            options: .curveEaseOut,
            animations: {
              if shouldDismissCard {
                self.frame = .init(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
              } else  {
                self.transform = .identity
              }
            }) { _ in
      self.transform = .identity
      if shouldDismissCard {
        self.removeFromSuperview()
      }
    }
  }


  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
