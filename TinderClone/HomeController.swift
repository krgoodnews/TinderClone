//
//  HomeController.swift
//  TinderClone
//
//  Created by 국윤수 on 23/06/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

  let topStackView = TopNavigationStackView()
  let cardsDeckView = UIView()
  let buttonsStackView = HomeBottomControlsStackView()

  let users = [
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    setupDummyCards()
  }

  fileprivate func setupDummyCards() {
    users.forEach {
      let cardView = CardView(frame: .zero)
      cardView.imageView.image = UIImage(named: $0.imageName)

      let attributedText = NSMutableAttributedString(string: $0.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
      attributedText.append(NSMutableAttributedString(string: "  \($0.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
      attributedText.append(NSMutableAttributedString(string: "\n\($0.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
      cardView.informationLabel.attributedText = attributedText

      cardsDeckView.addSubview(cardView)
      cardView.fillSuperview()
    }

  }

  private func setupLayout() {
    let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
    overallStackView.axis = .vertical
    view.addSubview(overallStackView)
    overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor)
    overallStackView.isLayoutMarginsRelativeArrangement = true
    overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)

    overallStackView.bringSubviewToFront(cardsDeckView)
  }

}

