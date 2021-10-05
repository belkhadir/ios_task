//
//  RecipeViewModel.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import Foundation

class RecipeViewModel {
    
    var recipes: [Recipe]
    
    init(result: CommonResult) {
        recipes = RecipeViewModel.mapping(from: result)
    }
    
    private static func mapping(from result: CommonResult) -> [Recipe] {
        var recipes = [Recipe]()
        let items = result.items
        
        // get all chef in a dictionary with this format:
        // Dictionary<ID , ChefName>
        var chefs = [String: String]()
        result
            .includes
            .entry
            .filter { $0.sys.contentType?.sys.id  == "chef" }
            .forEach { chefs[$0.sys.id] = $0.fields.name }
            
        
        // get all tags in a dictionary with this format:
        // Dictionary<ID , tag>
        var tags = [String: String]()
        result
            .includes
            .entry
            .filter { $0.sys.contentType?.sys.id  == "tag" }
            .forEach{ tags[$0.sys.id] = $0.fields.name }
        
        // get all photo in a dictionary with this format:
        // Dictionary<ID , photo>
        var photos = [String: String]()
        result
            .includes
            .asset
            .forEach{ photos [$0.sys.id] = $0.fields.file.url }
        
        // in the loop we try to construct a Recipe Model
        for element in items {
            
            let chef = chefs[element.fields.chef?.sys.id ?? ""]
            
            // we get all tag associated with recipe
            let tag = element.fields.tags?.map{ tags[$0.sys.id] ?? "" }
            
            // we setup the correct format url for the image
            let photo = "http:" + (photos[element.fields.photo.sys.id] ?? "")
            let url = URL(string: photo)
            
            recipes.append(Recipe(id: element.sys.id, title: element.fields.title, calories: element.fields.calories, description: element.fields.fieldsDescription, chef: chef, imageURL: url, tags: tag ?? []))

        }
        
        
        return recipes
    }
}
