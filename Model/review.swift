//
//  review.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import Foundation

struct review: Identifiable{
    var id: String = UUID().uuidString
    var restaurant: String = ""
    var IDENT: String = ""
    var thumbsUpCount: Int = 0
    var thumbsDownCount: Int = 0
}
