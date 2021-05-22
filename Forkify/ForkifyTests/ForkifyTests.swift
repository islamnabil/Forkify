//
//  ForkifyTests.swift
//  ForkifyTests
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import XCTest
@testable import Forkify

class ForkifyTests: XCTestCase {

    /// Access HomeAPI class to make HTTP Home requests
    var api:HomeAPIProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        api = HomeAPI()

    }

    override func tearDownWithError() throws {
        api = nil
        try super.tearDownWithError()
    }

    //MARK:- Test NetworkLayer Executes Success Request
    func testNetworkLayerExecuteSuccessRequest() {
        var recipes = RecipesModel()
        
        let expectation = expectation(description: "GET https://forkify-api.herokuapp.com/api/search?q=pizza")

        api.search(meal: "pizza", view: UIView()) { (result) in
            switch result {
            case .success(let response):
                recipes = response
                XCTAssert(recipes.recipes?.count ?? 0 > 0)
                expectation.fulfill()
            case .failure(let error):
                print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        }

        
        waitForExpectations(timeout: 10){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK:- Test fetch recipe details
    func testFetchRecipeDetails() {
        var recipeDetails = RecipeDetailsModel()
        
        let expectation = expectation(description: "GET https://forkify-api.herokuapp.com/api/get?rId=47746")

        api.recipeDetails(recipeId: "47746", view: UIView()) { (result) in
            switch result {
            case .success(let resposse):
                recipeDetails = resposse
                XCTAssert(recipeDetails.recipe != nil)
                expectation.fulfill()
            case .failure(let error):
                print(error)
            }
        }

        
        waitForExpectations(timeout: 10){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK:- Test Handle error response
    func testHandleErrorResponse() {
        api.recipeDetails(recipeId: "4746", view: UIView()) { (result) in
            switch result {
            case .success(_): break
            case .failure(let error):
                print(error)
                XCTAssert(error.description != "")
            }
        }
    }

    
    
}
