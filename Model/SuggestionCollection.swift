//
//  SuggestionCollection.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/18/22.
//

import Foundation

struct SuggestionCollection: Identifiable{
    var id: String = UUID().uuidString
    var IDENT: String
    var restaurantName: String
    var suggestions: [suggestion]
}
