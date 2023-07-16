//
//  Player.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//

import Foundation


// MARK: - Player
struct Player: Codable {
    let id, sportID, slug, name: String
    let nameTranslations: NameTranslations?
    let nameShort: String
    let photo: String?
    let position, positionName, weight, age: String
    let dateBirthAt, height, shirtNumber, preferredFoot: String
    let nationalityCode, flag, marketCurrency, marketValue: String
    let contractUntil, rating: String
  //  let characteristics: Characteristics
    let ability: [Ability]?
    let teamID, teamCategoryID, teamVenueID, teamManagerID: String
    let teamSlug, teamName: String
    let teamLogo: String
    let teamNameTranslations: TeamNameTranslations?
    let teamNameShort, teamNameFull, teamNameCode, teamHasSub: String
    let teamGender, teamIsNationality, teamCountryCode, teamCountry: String
    let teamFlag, teamFoundation, updated: String

    enum CodingKeys: String, CodingKey {
        case id
        case sportID = "sport_id"
        case slug, name
        case nameTranslations = "name_translations"
        case nameShort = "name_short"
        case photo, position
        case positionName = "position_name"
        case weight, age
        case dateBirthAt = "date_birth_at"
        case height
        case shirtNumber = "shirt_number"
        case preferredFoot = "preferred_foot"
        case nationalityCode = "nationality_code"
        case flag
        case marketCurrency = "market_currency"
        case marketValue = "market_value"
        case contractUntil = "contract_until"
        case rating, ability //characteristics
        case teamID = "team_id"
        case teamCategoryID = "team_category_id"
        case teamVenueID = "team_venue_id"
        case teamManagerID = "team_manager_id"
        case teamSlug = "team_slug"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamNameTranslations = "team_name_translations"
        case teamNameShort = "team_name_short"
        case teamNameFull = "team_name_full"
        case teamNameCode = "team_name_code"
        case teamHasSub = "team_has_sub"
        case teamGender = "team_gender"
        case teamIsNationality = "team_is_nationality"
        case teamCountryCode = "team_country_code"
        case teamCountry = "team_country"
        case teamFlag = "team_flag"
        case teamFoundation = "team_foundation"
        case updated
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name: String?
    let value, fullAverage: Int?

    enum CodingKeys: String, CodingKey {
        case name, value
        case fullAverage = "full_average"
    }
}

// MARK: - Characteristics
struct Characteristics: Codable {
    let positive, negative: [Tive]
}

// MARK: - Tive
struct Tive: Codable {
    let feature: String
    let value: Int
}

// MARK: - NameTranslations
struct NameTranslations: Codable {
    let en: String?
}

// MARK: - TeamNameTranslations
struct TeamNameTranslations: Codable {
    let en, ru, de, es: String?
    let fr, zh, tr, el: String?
    let it, nl, pt: String?
}
