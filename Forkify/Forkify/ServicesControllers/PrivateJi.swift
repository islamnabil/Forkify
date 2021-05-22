//
//  PrivateJi.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import Ji

/// Interface for `Ji` pod
class PrivateJi {
    
    
    /// Parse HTML elements of HTTP response with `Ji` pod
    ///
    /// - Parameters:
    ///   - link: URL of HTTP request
    ///   - path: Path of HTML element to be parsed in HTTP response
    /// - Returns: Array of string of elements content
    static func parseHTML(link:String, path:String) -> [String] {
        var contents = [String]()
        let jiDoc = Ji(htmlURL: URL(string: link)!)
        jiDoc?.xPath("/\(path)")?.first?.forEach({ node in
            guard let content = node.content else {return}
            contents.append(content)
        })
        return contents
    }
    
    
}
