//
//  review.swift
//  Flying For Food
//
//  Created by Rice on 9/9/21.
//

import Foundation

struct suggestion: Identifiable{
    var id: String = UUID().uuidString
    var IDENT: String
    var restaurantName: String
    var typeOfMeal: String
    var comment: String
    var firstLastName: String
}
