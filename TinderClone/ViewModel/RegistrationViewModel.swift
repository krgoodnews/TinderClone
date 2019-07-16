//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Yunsu Guk on 2019/07/01.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore

class RegistrationViewModel {

  var bindableIsRegistering = Bindable<Bool>()
  var bindableImage = Bindable<UIImage>()
  var bindableIsFormValid = Bindable<Bool>()

  var fullName: String? {
    didSet {
      checkFormValidity()
    }
  }
  var email: String? {
    didSet {
      checkFormValidity()
    }
  }
  var password: String? {
    didSet {
      checkFormValidity()
    }
  }

  func performRegistration(completion: @escaping (Error?) -> ()) {

    guard let email = email,
          let password = password else { return }

    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if let error = error {
        completion(error)
        return
      }

      print("successfully registered user:", result?.user.uid ?? "")

      self.saveImageToFirebase(completion: completion)
    }
  }

  fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
    // Only upload images to Firebase Storage once you are auth
    let filename = UUID().uuidString
    let ref = Storage.storage().reference(withPath: "/images/\(filename)")
    let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
    ref.putData(imageData, metadata: nil) { _, error in

      if let err = error {
        completion(err)
        return // bail
      }

      print("Finished uploading image to storage")
      ref.downloadURL { url, error in
        if let err = error {
          completion(err)
          return
        }

        self.bindableIsRegistering.value = false
        print("Download url of our image is:", url?.absoluteString ?? "")

        let imageURL = url?.absoluteString ?? ""
        self.saveInfoToFirestore(imageURL: imageURL, completion: completion)
      }
    }
  }

  fileprivate func saveInfoToFirestore(imageURL: String,
                                       completion: @escaping (Error?) -> ()) {

    let uid = Auth.auth().currentUser?.uid ?? ""
    let docData = ["fullName": fullName ?? "",
                   "imageURL1": imageURL,
                   "uid": uid]
    Firestore.firestore().collection("users").document(uid).setData(docData) { error in 
      if let err = error {
        completion(err)
        return
      }

      completion(nil)
    }
  }
  
  fileprivate func checkFormValidity() {
    let isFormValid = fullName?.isEmpty == false
      && email?.isEmpty == false
      && password?.isEmpty == false

    bindableIsFormValid.value = isFormValid
  }
}
