//
//  SubscriptionsData.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-22.
//

import Foundation

struct Subscription: Identifiable, Codable {
    var id: String
    var year: Int
    var month: String
    var description: String
    var amount: Double
}

