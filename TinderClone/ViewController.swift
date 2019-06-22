//
//  ViewController.swift
//  TinderClone
//
//  Created by 국윤수 on 23/06/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let topStackView = TopNavigationStackView()
  let blueView = UIView()
  let buttonsStackView = HomeBottomControlsStackView()

  override func viewDidLoad() {
    super.viewDidLoad()

    blueView.backgroundColor = .blue

    setupLayout()

  }

  private func setupLayout() {
    let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonsStackView])
    overallStackView.axis = .vertical
    view.addSubview(overallStackView)
    overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor)
  }

}

