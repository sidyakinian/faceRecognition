//
//  Data.swift
//  SourceFiles
//
//  Created by sidyakinian on 21/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

import UIKit

class Person {
    var identifier: [Float]
    var link: String
    
    init(identifier: [Float], link: String) {
        self.identifier = identifier
        self.link = link
    }
    
    init(_ pictureName: String, link: String) {
        let image = UIImage(named: pictureName)?.cgImage
        let array = FaceAPI.getArrayFromImage(image!)
        self.identifier = array
        self.link = link
    }
}

var people: [Person] = [
    Person("putin", link: "Vova"),
    Person("trump", link: "Donald"),
    Person("barack", link: "Barack"),
    Person("tim", link: "Timmy"),
    Person("bill", link: "Bill"),
    Person("justin", link: "Justin")
]
