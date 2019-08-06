//
// Created by 국윤수 on 2019-06-23.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
  var name: String?
  var age: Int?
  var profession: String?
  var imageNames: [String]?
  var uid: String?

  init(dic: [String: Any]) {

    self.name = dic["fullName"] as? String ?? ""
    self.age = dic["age"] as? Int
    self.profession = dic["profession"] as? String

    let imageURL1 = dic["imageURL1"] as? String ?? ""
    self.imageNames = [imageURL1]

    self.uid = dic["uid"] as? String ?? ""

  }

  func toCardViewModel() -> CardViewModel {

    let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])

    let ageString = age == nil
            ? "N\\A" 
            : "\(age!)"
    attributedText.append(NSMutableAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))

    let professionString = profession == nil
            ? "Not available"
            : profession!
    attributedText.append(NSMutableAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))

    return CardViewModel(imageNames: imageNames ?? [], attributedString: attributedText, textAlignment: .left)
  }
}

