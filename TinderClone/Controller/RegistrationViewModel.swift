//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Yunsu Guk on 2019/07/01.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class RegistrationViewModel {

  var bindableImage = Bindable<UIImage>()
  var bindableIsFormValid = Bindable<Bool>()

  var fullName: String? {
    didSet {
      checkFormValidity()
    }
  }
  var email: String? { didSet {
    checkFormValidity()
    }
  }
  var password: String? { didSet {
    checkFormValidity()
    }
  }
  
  fileprivate func checkFormValidity() {
    let isFormValid = fullName?.isEmpty == false
      && email?.isEmpty == false
      && password?.isEmpty == false

    bindableIsFormValid.value = isFormValid
  }
}
