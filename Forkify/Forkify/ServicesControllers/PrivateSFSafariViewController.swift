//
//  SFSafari.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import UIKit
import SafariServices

/// Interface for `SafariServices`
 class PrivateSFSafariViewController {
    
    /// Present `SFSafariViewController`
    /// - Parameters:
    ///   - link: Link to be preseted.
    ///   - ViewController: The viewController presets SFSafariViewController.
    static func present(link:String, presentFrom ViewController:UIViewController) {
        if let url = URL(string:link) {
            let vc =  SFSafariViewController(url: url)
            ViewController.present(vc, animated: true)
        }
        
    }
}
