//
//  SwiftViewController.swift
//  JWPlayer-SDK-iOS-Demo
//
//  Created by Amitai Blickstein on 2/26/19.
//  Copyright © 2019 JWPlayer. All rights reserved.
//

import UIKit
import AVFoundation

class SwiftViewController: UIViewController {
    @IBOutlet weak var playerContainerView: UIView!
    var player: JWPlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config: JWConfig//  = JWConfig(contentURL: "http://content.bitsontherun.com/videos/3XnJSIm4-injeKYZS.mp4")
        = JWConfig(contentURL: "http://localhost:9000/stream.m3u8")
//        config.assetOptions = ["AVURLAssetHTTPHeaderFieldsKey": ["cookie": "cookie data"]]
        
        let cookie = HTTPCookie(properties: [
            HTTPCookiePropertyKey.name: "foo",
            HTTPCookiePropertyKey.value: "bar",
            HTTPCookiePropertyKey.domain: "127.0.0.1",
            HTTPCookiePropertyKey.path: "/",
        ])!
        
        config.assetOptions = [
            "AVURLAssetHTTPHeaderFieldsKey": ["foo": "cookie data"],
            AVURLAssetHTTPCookiesKey: [cookie],
        ]
        
        
        player = JWPlayerController(config: config)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let playerView = player?.view {
            playerContainerView.addSubview(playerView)
            playerView.constrainToSuperview()
        }
    }
}


// MARK: - Helper method

extension UIView {
    /// Constrains the view to its superview, if it exists, using Autolayout.
    /// - precondition: For player instances, JWP SDK 3.3.0 or higher.
    @objc func constrainToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[thisView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["thisView": self])
        
        let verticalConstraints   = NSLayoutConstraint.constraints(withVisualFormat: "V:|[thisView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["thisView": self])
        
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
    }
}
