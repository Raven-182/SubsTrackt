//
//  SubscriptionsData.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-22.
//

import Foundation

struct Subscription: Identifiable, Codable {
    var id: String
    var endDate: Date
    var startDate: Date
    var description: String
    var amount: Double
    var category: String
}

