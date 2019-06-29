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

  let cardViewModels: [CardViewModel] = {
    let producers: [ProducesCardViewModel] = [
      Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: "slide_out_menu_poster"),
      User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2"]),
      User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
    ]

    return producers.map { $0.toCardViewModel() }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    setupDummyCards()
  }

  fileprivate func setupDummyCards() {
    cardViewModels.forEach {
      let cardView = CardView(frame: .zero)
      cardView.cardViewModel = $0
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

