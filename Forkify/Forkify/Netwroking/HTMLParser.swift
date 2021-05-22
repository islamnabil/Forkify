//
//  HTMLParser.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import PKHUD

class HTMLParser {
    
    /// URL of to be parsed
    private var link:String
    
    /// Path of HTML element in HTTP response
    private var path:String
    
    
    init(link:String, path:String) {
        self.link = link
        self.path = path
    }
    
    
    /// Parse HTML elements of HTTP response
    func parse(completion: @escaping ([String]) -> () ) {
        HUD.show(.progress)
        DispatchQueue.global().async {
            let response = PrivateJi.parseHTML(link: self.link, path: self.path)
            DispatchQueue.main.async {
                HUD.hide()
                completion(response)
            }
        }
    }
    
}
