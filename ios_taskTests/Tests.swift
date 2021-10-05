//
//  ios_task.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import XCTest
@testable import ios_task

class Tests: XCTestCase {

    var recipes: [Recipe]?
    
    override func setUp() {
        super.setUp()
        
        guard let data = readLocalFile(forName: "data") else { return }
        let result = try? JSONDecoder().decode(CommonResult.self, from: data)
        
        XCTAssertNotNil(result, "Should not be nil")
        
        guard let result = result else { return }
        
        let viewModel = RecipeViewModel(result: result)
        recipes = viewModel.recipes
    }

    override func tearDown() {
        recipes = nil
        super.tearDown()
    }

    func testCaseTagForRecipe() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let recipe1 = recipes?[0]
        
        XCTAssertFalse(recipe1!.tags.isEmpty)
        
        let recipe2 = recipes?.last
        
        XCTAssertEqual(recipe2!.tags.count, 2)
    }

    func testCaseChefForRecipe() throws {
        
        let recipe1 = recipes?[0]
        
        XCTAssertNil(recipe1!.chef)
        
        
        let recipe2 = recipes?.last
        
        XCTAssertFalse(recipe2!.chef!.isEmpty)
    }
    
    func testCaseImageForRecipe() throws {
        
        let recipe1 = recipes?[0]
        let url = URL(string: "http://images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg")
        
        XCTAssertEqual(recipe1!.imageURL, url)
        
    }
    
    func testCaseForRecipe() throws {
        
        let recipe1 = recipes?[0]
        
        XCTAssertEqual(recipe1!.title, "White Cheddar Grilled Cheese with Cherry Preserves & Basil")
        XCTAssertEqual(recipe1!.description, "*Grilled Cheese 101*: Use delicious cheese and good quality bread; make crunchy on the outside and ooey gooey on the inside; add one or two ingredients for a flavor punch! In this case, cherry preserves serve as a sweet contrast to cheddar cheese, and basil adds a light, refreshing note. Use __mayonnaise__ on the outside of the bread to achieve the ultimate, crispy, golden-brown __grilled cheese__. Cook, relax, and enjoy!")
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // helper method to read file
    private func readLocalFile(forName name: String) -> Data? {
        do {
            let bundle = Bundle(for: type(of: self))
            if let  bundlePath = bundle.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }

}

