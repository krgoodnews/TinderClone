//
//  HomeController.swift
//  TinderClone
//
//  Created by 국윤수 on 23/06/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeController: UIViewController {

  let topStackView = TopNavigationStackView()
  let cardsDeckView = UIView()
  let buttonsStackView = HomeBottomControlsStackView()

  var cardViewModels = [CardViewModel]()

  override func viewDidLoad() {
    super.viewDidLoad()

    topStackView.settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
    setupLayout()
    setupDummyCards()
    fetchUsersFromFirestore()
  }

  private func fetchUsersFromFirestore() {
    Firestore.firestore().collection("users").getDocuments { snapshot, error in 
      if let err = error {
        print("--- Failed to fetch users:", err)
        return
      }

      snapshot?.documents.forEach { documentSnapshot in
        let userDictionary = documentSnapshot.data()
        let user = User(dic: userDictionary)
        self.cardViewModels.append(user.toCardViewModel())
      }
      self.setupDummyCards()
    }
  }

  @objc private func didTapSettings() {
    print("show registration page")
    let registrationController = RegistrationController()
    present(registrationController, animated: true)
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
    view.backgroundColor = .white
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
