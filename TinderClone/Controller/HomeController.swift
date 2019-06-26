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

  let cardViewModels = [
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    setupDummyCards()
  }

  fileprivate func setupDummyCards() {
    cardViewModels.forEach {
      let cardView = CardView(frame: .zero)
      cardView.imageView.image = UIImage(named: $0.imageName)
      cardView.informationLabel.attributedText = $0.attributedString
      cardView.informationLabel.textAlignment = $0.textAlignment

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

