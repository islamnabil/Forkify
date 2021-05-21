//
//  SFSafari.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import UIKit
import SafariServices

class SafariServicesController {
    
    static func present(link:String, presentFrom ViewController:UIViewController) {
        if let url = URL(string:link) {
            let vc =  SFSafariViewController(url: url)
            ViewController.present(vc, animated: true)
        }
        
    }
}
