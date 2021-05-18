//
//  HTMLParser.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation

class HTMLParser {
    private var link:String
    private var path:String
    
    init(link:String, path:String) {
        self.link = link
        self.path = path
    }
    
    func parse() -> [String] {
        return PrivateJi.shared.parseHTML(link: link, path: path)
    }
}
