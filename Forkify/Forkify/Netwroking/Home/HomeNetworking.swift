//
//  HomeNetworking.swift
//  Forkify
//
//  Created by Islam Elgaafary on 19/05/2021.
//

import Foundation
import Alamofire

enum HomeNetworking {
    case recipeSearch(q:String)
    case recipeDetails(rld:String)
}

extension HomeNetworking: TargetType {
    var baseURL: String {
        return "\(Domain.url)"
    }
    
    var path: String {
        switch self {
        case .recipeSearch:
            return "search"
        case .recipeDetails:
            return "get"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .recipeSearch(let q):
            return .requestParameters(parameters: [
                "q":q
            ], encoding: URLEncoding.default)
            
        case .recipeDetails(let rld):
            return .requestParameters(parameters: [
                "rld":rld
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
            "Accept":"application/json"
            ]
        }
    }
    
    
}
