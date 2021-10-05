//
//  CommonResult.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import Foundation

// MARK: - CommonResult
struct CommonResult: Codable {
    let sys: Sys
    let total, skip, limit: Int
    let items: [Item]
    let includes: Includes
}

// MARK: - Includes
struct Includes: Codable {
    let entry: [Entry]
    let asset: [Asset]

    enum CodingKeys: String, CodingKey {
        case entry = "Entry"
        case asset = "Asset"
    }
}

// MARK: - Asset
struct Asset: Codable {
    let sys: AssetSys
    let fields: AssetFields
}

// MARK: - AssetFields
struct AssetFields: Codable {
    let title: String
    let file: File
}

// MARK: - File
struct File: Codable {
    let url: String
    let details: Details
    let fileName, contentType: String
}

// MARK: - Details
struct Details: Codable {
    let size: Int
    let image: Image
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int
}

// MARK: - Metadata

// MARK: - AssetSys
struct AssetSys: Codable {
    let space: Chef
    let id: String
    let type: LinkTypeEnum
    let createdAt, updatedAt: String
    let environment: Chef
    let revision: Int
    let locale: Locale
    let contentType: Chef?
}

// MARK: - Chef
struct Chef: Codable {
    let sys: ChefSys
}

// MARK: - ChefSys
struct ChefSys: Codable {
    let id: String
    let type: PurpleType
    let linkType: LinkTypeEnum
}

enum LinkTypeEnum: String, Codable {
    case asset = "Asset"
    case contentType = "ContentType"
    case entry = "Entry"
    case environment = "Environment"
    case space = "Space"
}

enum PurpleType: String, Codable {
    case link = "Link"
}

enum Locale: String, Codable {
    case enUS = "en-US"
}

// MARK: - Entry
struct Entry: Codable {
    let sys: AssetSys
    let fields: EntryFields
}

// MARK: - EntryFields
struct EntryFields: Codable {
    let name: String
}

// MARK: - Item
struct Item: Codable {
    let sys: AssetSys
    let fields: ItemFields
}

// MARK: - ItemFields
struct ItemFields: Codable {
    let title: String
    let photo: Chef
    let calories: Int
    let fieldsDescription: String
    let tags: [Chef]?
    let chef: Chef?

    enum CodingKeys: String, CodingKey {
        case title, photo, calories
        case fieldsDescription = "description"
        case tags, chef
    }
}

// MARK: - WelcomeSys
struct Sys: Codable {
    let type: String
}
