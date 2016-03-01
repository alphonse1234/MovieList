//
//  IMDBVC.swift
//  MyMovieList
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 All rights reserved.
//

import UIKit
import WebKit
import CoreData

class IMDBVC: UIViewController {

    @IBOutlet var container: UIView!
    var webView: WKWebView!
    var movie: Movie!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        container.addSubview(webView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRect(x: 0, y: 0, width: container.bounds.width, height: container.bounds.height)
        webView.frame = frame
        
        loadRequest()
        
    }

    func loadRequest() {
        if let url = NSURL(string: movie.url!) {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
            
        }
        
        
    }
}


