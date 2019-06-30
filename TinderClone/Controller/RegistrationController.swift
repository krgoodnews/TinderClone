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

  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    button.backgroundColor = UIColor.rgb(red: 255, green: 80, blue: 80)
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupGradientLayer()
    setupLayout()
    setupNotificationObservers()
    setupTapGesture()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Private

  private func setupTapGesture() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
  }

  @objc private func handleTapDismiss() {
    self.view.endEditing(true)
  }
  
  private func setupNotificationObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc private func handleKeyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
  }

  @objc private func handleKeyboardShow(notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardFrame = value.cgRectValue

    // figure out how tall the gap is from the register button to the bottom of the screen
    let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height

    let difference = keyboardFrame.height - bottomSpace
    self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
  }

  lazy var stackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    fullNameTextField,
    emailTextField,
    passwordTextField,
    registerButton
  ])

  private func setupLayout() {
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

