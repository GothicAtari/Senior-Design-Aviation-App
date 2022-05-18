//
//  RestaurantNetReview.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/11/22.
//

import Foundation

struct RestaurantNetReview: Identifiable{
    var id: String = UUID().uuidString
    var restaurant: String
    var IDENT: String
    var netReviews: Int
}
