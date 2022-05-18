//
//  airportReviews.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import Foundation

struct airportReviewColls: Identifiable{
    var id: String = UUID().uuidString
    var IDENT: String = ""
    var breakfastCollection: reviewCollection
    var lunchCollection: reviewCollection
    var dinnerCollection: reviewCollection
}
