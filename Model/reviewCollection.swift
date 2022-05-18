//
//  reviewCollection.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import Foundation


struct reviewCollection: Identifiable{
    var id: String = UUID().uuidString
    var IDENT: String = ""
    var reviews: [review] = []
}

