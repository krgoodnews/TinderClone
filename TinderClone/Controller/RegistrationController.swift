//
// Created by 국윤수 on 2019-06-30.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import Firebase
import JGProgressHUD

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
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()

  let emailTextField: CustomTextField = {
    let tf = CustomTextField()
    tf.keyboardType = .emailAddress
    tf.placeholder = "Enter email"
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()

  let passwordTextField: CustomTextField = {
    let tf = CustomTextField()
    tf.placeholder = "Enter password"
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  
  @objc private func handleTextChange(textField: UITextField) {
    if textField == fullNameTextField {
      registrationViewModel.fullName = textField.text
    } else if textField == emailTextField {
      registrationViewModel.email = textField.text
    } else {
      registrationViewModel.password = textField.text
    }
  }


  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    button.backgroundColor = .lightGray
    button.isEnabled = false
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    return button
  }()

  @objc fileprivate func didTapRegister() {
    self.handleTapDismiss()
    print("Register")

    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }

    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if let error = error {
        print("error = \(error)")
        self.showHUDWithError(error: error)
        return
      }

      print("successfully registered user:", result?.user.uid ?? "")
    }
  }

  private func showHUDWithError(error: Error) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Failed registration"
    hud.detailTextLabel.text = error.localizedDescription
    hud.show(in: self.view)
    hud.dismiss(afterDelay: 4)

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupGradientLayer()
    setupLayout()
    setupNotificationObservers()
    setupTapGesture()
    setupRegistrationViewModelObserver()
  }

  let registrationViewModel = RegistrationViewModel()
  private func setupRegistrationViewModelObserver() {
    registrationViewModel.isFormValidObserver = { (isFormValid) in
      print("Form is changing, is it valid?", isFormValid)

      self.registerButton.isEnabled = isFormValid
      if isFormValid {
        self.registerButton.backgroundColor = UIColor.rgb(red: 200, green: 70, blue: 30)
        self.registerButton.setTitleColor(.white, for: .normal)
      } else {
        self.registerButton.backgroundColor = .lightGray
        self.registerButton.setTitleColor(.gray, for: .normal)
      }
    }
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
    let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height

    let difference = keyboardFrame.height - bottomSpace
    self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
  }

  lazy var verticalStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      registerButton
    ])
    sv.axis = .vertical
    sv.distribution = .fillEqually
    sv.spacing = 8
    return sv
  }()

  lazy var overallStackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    verticalStackView
  ])

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if self.traitCollection.verticalSizeClass == .compact {
      overallStackView.axis = .horizontal
    } else {
      overallStackView.axis = .vertical
    }
  }

  private func setupLayout() {
    view.addSubview(overallStackView)

    overallStackView.axis = .horizontal

    overallStackView.spacing = 8
    overallStackView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  private let gradientLayer = CAGradientLayer()

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    gradientLayer.frame = view.bounds
  }

  private func setupGradientLayer() {
    let topColor = UIColor.rgb(red: 253, green: 91, blue: 95)
    let bottomColor = UIColor.rgb(red: 229, green: 0, blue: 114)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0, 1]
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }
}

