//
//  SubscriptionCategories.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-29.
//

import Foundation


import Foundation
import SwiftUI
enum SubscriptionCategory: String, CaseIterable, Identifiable {
    case youtube
    case spotify
    case netflix
    case openAI
    case hulu
    case disneyPlus
    case appleMusic
    case amazonPrime
    case audible
    case microsoftOffice
    case dropbox
    case googleDrive
    case adobeCreativeCloud
    case other

    var id: String { self.rawValue }

    var logo: String {
        switch self {
        case .youtube:
            return "youtube"
        case .spotify:
            return "spotify"
        case .netflix:
            return "netflix"
        case .openAI:
            return "openAI"
        case .hulu:
            return "hulu"
        case .disneyPlus:
            return "disney plus"
        case .appleMusic:
            return "apple music"
        case .amazonPrime:
            return "amazon prime"
        case .audible:
            return "audible"
        case .microsoftOffice:
            return "microsoft office"
        case .dropbox:
            return "dropbox"
        case .googleDrive:
            return "google drive"
        case .adobeCreativeCloud:
            return "adobe creative cloud"
        case .other:
            return "other"
        }
    }

    var displayName: String {
        switch self {
        case .youtube:
            return "YouTube Premium"
        case .spotify:
            return "Spotify"
        case .netflix:
            return "Netflix"
        case .openAI:
            return "OpenAI"
        case .hulu:
            return "Hulu"
        case .disneyPlus:
            return "Disney+"
        case .appleMusic:
            return "Apple Music"
        case .amazonPrime:
            return "Amazon Prime"
        case .audible:
            return "Audible"
        case .microsoftOffice:
            return "Microsoft Office"
        case .dropbox:
            return "Dropbox"
        case .googleDrive:
            return "Google Drive"
        case .adobeCreativeCloud:
            return "Adobe Creative Cloud"
        case .other:
            return "Other"
        }
    }
}
