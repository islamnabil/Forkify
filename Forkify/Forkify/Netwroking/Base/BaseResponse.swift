//
//  BaseResponse.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var status: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
    
}
