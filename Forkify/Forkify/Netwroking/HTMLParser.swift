//
//  HTMLParser.swift
//  Forkify
//
//  Created by Islam Elgaafary on 18/05/2021.
//

import Foundation
import PKHUD

class HTMLParser {
    private var link:String
    private var path:String
    
    init(link:String, path:String) {
        self.link = link
        self.path = path
    }
    
    func parse(completion: @escaping ([String]) -> () ) {
        HUD.show(.progress)
        DispatchQueue.global().async {
            let response = PrivateJi.shared.parseHTML(link: self.link, path: self.path)
            DispatchQueue.main.async {
                HUD.hide()
                completion(response)
            }
        }
    }
}
