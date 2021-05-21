//
//  PrivateJi.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import Ji

class PrivateJi {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = PrivateJi()
    
    func parseHTML(link:String, path:String) -> [String] {
        var contents = [String]()
        let jiDoc = Ji(htmlURL: URL(string: link)!)
        jiDoc?.xPath("/\(path)")?.first?.forEach({ node in
            guard let content = node.content else {return}
            contents.append(content)
        })
        return contents
    }
}
