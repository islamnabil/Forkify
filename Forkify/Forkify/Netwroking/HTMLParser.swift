//
//  HTMLParser.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import PKHUD

class HTMLParser {
    
    /// URL link
    private var link:String
    
    /// Path of HTML element to be parsed in HTTP response
    private var path:String
    
    
    init(link:String, path:String) {
        self.link = link
        self.path = path
    }
    
    
    /// Parse HTML elements of HTTP response
    func parse(completion: @escaping ([String]) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            let response = PrivateJi.parseHTML(link: self.link, path: self.path)
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
    
}
