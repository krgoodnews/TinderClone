//
//  ViewController.swift
//  TinderClone
//
//  Created by 국윤수 on 23/06/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let subviews: [UIView] = [UIColor.gray, UIColor.darkGray, UIColor.black].map {
      let v = UIView()
      v.backgroundColor = $0
      return v
    }

    let topStackView = UIStackView(arrangedSubviews: subviews)
    topStackView.distribution = .fillEqually
    topStackView.backgroundColor = .red
    topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true

    let blueView = UIView()
    blueView.backgroundColor = .blue

    let yellowView = UIView()
    yellowView.backgroundColor = .yellow
    yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true

    let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowView])
    stackView.axis = .vertical

    view.addSubview(stackView)
    stackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
    stackView.fillSuperview()

  }


}

