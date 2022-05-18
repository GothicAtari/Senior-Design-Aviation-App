//
//  account.swift
//  Flying For Food
//
//  Created by Rice on 9/25/21.
//

import Foundation

struct account: Identifiable{
    var id: String = UUID().uuidString
    var firstAndLastName: String
    var emailAddress: String
    var password: String
    var homeAirport: String
    var aircraftType: String
    var role: String
}
