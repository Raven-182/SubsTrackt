//
//  SubscriptionsData.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-22.
//
import Foundation

struct Subscription: Identifiable, Codable {
    var id: String
    var amount: Double
    var category: String
    var description: String
    var startDate: Date
    var endDate: Date

    // Custom initializer to handle the conversion of dates
    init(id: String, amount: Double, category: String, description: String, startDate: Date, endDate: Date) {
        self.id = id
        self.amount = amount
        self.category = category
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }

    // Coding keys to match Firebase field names
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case category
        case description
        case startDate
        case endDate
    }
}

