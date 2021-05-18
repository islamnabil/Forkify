//
//  Constants.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation

struct ErrorMessage {
    static let genericError = "Something went wrong please try again later"
}

struct Domain {
    static let url = "https://forkify-api.herokuapp.com/api/"
}

struct ErrorMsg:Codable {
    var msg:[String]
}
