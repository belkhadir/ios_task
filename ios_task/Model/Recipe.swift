//
//  Recipe.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    var id: String
    
    let title: String
    let calories: Int
    let description: String
    let chef: String?
    let imageURL: URL?
    let tags: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}
