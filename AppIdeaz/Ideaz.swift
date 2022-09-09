//
//  Ideaz.swift
//  AppIdeaz
//
//  Created by Ayberk M on 7.09.2022.
//

import Foundation
import UIKit
//modelimsi



struct Ideaz {
    let title: String
    let description: String
    let image: String
    let isEvaluated: Bool
    
    init(title: String, isEvaluated: Bool = false, image: String, description: String ) {
      self.title = title
      self.isEvaluated = isEvaluated
        self.image = image
        self.description = description
    }
    
    func completeToggled() -> Ideaz {
      return Ideaz(title: title, isEvaluated: !isEvaluated, image: image, description: description)
    }
    
}


