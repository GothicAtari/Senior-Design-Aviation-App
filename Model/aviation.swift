//
//  aviation.swift
//  Flying For Food
//
//  Created by Rice on 8/26/21.
//

import Foundation

struct aviation: Identifiable{
    var id: String = UUID().uuidString
    var IDENT: String
    var CityState: String
    var FBO: String
    var Breakfast: String
    var Lunch: String
    var Dinner: String
    var CoffeeShop: String
    var Dessert: String
    var OtherOptionsNotes: String
}
