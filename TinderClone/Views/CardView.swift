//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class CardView: UIView {

  var cardViewModel: CardViewModel? {
    didSet {
      let imageName = cardViewModel?.imageNames.first ?? ""
      imageView.image = UIImage(named: imageName)
      informationLabel.attributedText = cardViewModel?.attributedString
      informationLabel.textAlignment = cardViewModel?.textAlignment ?? .left

      (0..<(cardViewModel?.imageNames.count ?? 0)).forEach { _ in
        let barView = UIView()
        barView.backgroundColor = barDeselectColor
        barsStackView.addArrangedSubview(barView)
      }
      barsStackView.arrangedSubviews.first?.backgroundColor = .white
    }
  }

  private let threshold: CGFloat = 80

  fileprivate let imageView = UIImageView(image: UIImage(named: "lady5c"))
  fileprivate let gradientLayer = CAGradientLayer()
  fileprivate let informationLabel = UILabel()

  var imageIndex = 0
  private let barDeselectColor = UIColor(white: 0, alpha: 0.1)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()

    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)

    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  }

  @objc private func handleTap(gesture: UITapGestureRecognizer) {
    print("handleTap")
    let tapLocation = gesture.location(in: nil)

    guard let viewModel = cardViewModel else {
      return
    }

    let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
    if shouldAdvanceNextPhoto {
      imageIndex = min(imageIndex + 1, viewModel.imageNames.count - 1)
    } else {
      imageIndex = max(imageIndex - 1, 0)
    }

    let imageName = cardViewModel?.imageNames[imageIndex] ?? ""
    imageView.image = UIImage(named: imageName)
    barsStackView.arrangedSubviews.forEach {
      $0.backgroundColor = barDeselectColor
    }
    barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
  }

  private func setupLayout() {
    layer.cornerRadius = 10
    clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    addSubview(imageView)
    imageView.fillSuperview()

    setupGradientLayer()
    setupBarsStackView()

    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    informationLabel.text = "TEST NAME TEST NAME TEST AGE"
    informationLabel.textColor = .white
    informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
    informationLabel.numberOfLines = 0
  }

  let barsStackView = UIStackView()
  private func setupBarsStackView() {

    addSubview(barsStackView)
    barsStackView.anchor(top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 0, right: 8),
            size: .init(width: 0, height: 4))

    barsStackView.spacing = 4
    barsStackView.distribution = .fillEqually
  }

  private func setupGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor,
                            UIColor.black.cgColor]
    gradientLayer.locations = [0.5, 1.1]

    layer.addSublayer(gradientLayer)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // CardView frame will be
    gradientLayer.frame = self.frame
  }

  @objc private func handlePan(gesture: UIPanGestureRecognizer) {

    switch gesture.state {
    case .began:

      superview?.subviews.forEach {
        $0.layer.removeAllAnimations()
      }
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
