//
// Created by 국윤수 on 2019-06-30.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

  // MARK: - UI Components
  let selectPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 275).isActive = true
    button.layer.cornerRadius = 16
    return button
  }()

  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField()
    tf.placeholder = "Enter full Name"
    return tf
  }()

  let emailTextField: CustomTextField = {
    let tf = CustomTextField()
    tf.placeholder = "Enter email"
    return tf
  }()

  let passwordTextField: CustomTextField = {
    let tf = CustomTextField()
    tf.placeholder = "Enter password"
    tf.isSecureTextEntry = true
    return tf
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupGradientLayer()

    let stackView = UIStackView(arrangedSubviews: [
      selectPhotoButton,
      fullNameTextField,
      emailTextField,
      passwordTextField
    ])

    view.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  private func setupGradientLayer() {
    let gradientLayer = CAGradientLayer()
    let topColor = UIColor.rgb(red: 253, green: 91, blue: 95)
    let bottomColor = UIColor.rgb(red: 229, green: 0, blue: 114)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0, 1]
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }
}

